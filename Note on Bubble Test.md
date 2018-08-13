## Note on Bubble Test

### 1. Introduction

As argued in the literature recently, financial crises are often preceded by an asset market bubble. The exuberance behavior indicates higher financial risks, and hence detection of exuberance in financial markets by explicit quantitative measures becomes increasingly important.

Econometricians have been developing econometric tools to test the existence of bubbles. For stock price data, motivated by asset pricing theory, Diba and Grossman (1989) proposed to test bubbles by apply unit-root test to the first differenced price level $\Delta p_t$ and cointegration test to  the stock price $p_t $ and the dividend series $d_t$, and found no evidence of bubbles in historical data. In the later work, Evans (1991) showed that standard tests fail to detect explosive bubbles due to periodically collapsed bubbles, i.e. standard tests show no evidence of exuberance if the sample contains the whole bubble periods from emerging to burst.

Phillips, Wu and Yu (2011, PWY) proposed to apply the right-tailed augmented Dickey-Fuller (ADF) test to a unit-root against the alternative of an explosive root recursively with forward recursive rolling windows. In contrast to former works, PWY found strong evidence of explosive characteristic in $p_t$ when data from 1990s are included. 

As a real-time warning alert system, the key drawback of PWY is that it suffers from reduced power and can be inconsistent when the sample period includes multiple bubble periods. Following up PWY, Phillips, Shi and Yu (2015, PSY) proposed a generalized sup ADF test (GSADF), which allows both the starting point and ending point of the rolling window to be flexible, and a recursive backward regression technique to test the existence of exuberance and date-stamp the bubble origination and termination date, which overcomes the weakness of PWY. 

In this report, we follow the method proposed in PSY to perform bubble tests on $8$ financial time series. For completeness, we briefly introduce the method and implementation details in the following and Section 2, and present results in Section 3.

### 2. Method and Implementation

The bubble detection procedure consist mainly two parts: test the existence of exuberance behavior and date-stamp the bubble periods, both based on the rolling regression. We formulate the model first and then introduce the test statistics and the date-stamping strategy.

#### Model Specification

In both classical unit root tests and right-tailed unit root tests, model specification under the null matters for both estimation purpose and also the asymptotic distribution. Based on Phillips, Shen and Yu (2014), we consider a martingale null with an asymptotically negligible drift, which captures the mild drift in price processes,
$$
y_t = dT^{-\eta} + \theta y_{t-1} +\varepsilon_t
$$
where $\varepsilon_t \sim^{iid}\left(0, \sigma^2\right)$, $\theta = 1$, $T$ is the sample size, $d$ is a constant and $\eta > \frac{1}{2}$ is a localizing parameter that controls the drift as $T\to \infty$.

The model is equivalent to $y_t = d\frac{t}{T^\eta} + \sum^t_{j=1} \varepsilon_j + y_0$ with deterministic drift $d\frac{t}{T^\eta}$. We focus on the case where $\eta >\frac{1}{2}$ in which the order of $y_t$ is the same as a pure random walk.

Complemented with transient dynamics as in standard ADF test and with the rolling window regression sample starting from $r_1^{th}$ fraction of the whole sample ($T$) and endig at the $r_2^{th}$ fraction of the sample, we have the empirical regression model
$$
\Delta y_t = \alpha_{r_1, r_2} +\beta_{r_1, r_2}y_{t-1} + \sum_{i=1}^k \psi_{r_1, r_2}^{i}\Delta y_{t-i} + \varepsilon_t
$$
where $k$ is the lag order, which can be selected by Bayesian Information Criteria (BIC) in the empirical analysis, ADF statistic based on the regression is denoted by $ADF_{r_1}^{r_2}$, and the sample size $T_w = \lfloor Tr_w\rfloor$ where $r_w = r_2 - r_1$. To initialized the rolling regression, we need to set a smallest window width $r_0$, which is chosen by the rule proposed in PSY, $r_0 = 0.01 + 1.8/\sqrt{T}$.

#### Test Statistics

In PWY, the starting point of the rolling window is fixed as $0$ and $r_w$ rolls forward from $r_0$ to $1$, and the PWY test is based on a sup ADF statistic
$$
{SADF}\left(r_0\right) = \sup_{r2 \in [r_0, 1]} {ADF}_{0}^{r_2}
$$
The GSADF test developed in PSY generalizes the SADF test by varying both the starting and the ending point of the rolling window:
$$
{GSADF}\left(r_0\right) = \sup_{\substack{ r_2 \in [r_0 , 1]\\r_1 \in [0, r_2 - r_0] }}\left\{  {ADF}_{r_1}^{r_2} \right\}
$$
Under the model specification we introduced in the null, the limit distribution of GSADF is
$$
\sup_{\substack{ r_2 \in [r_0 , 1]\\r_1 \in [0, r_2 - r_0] }}\left\{ \frac{\frac{1}{2}r_w \left[ W(r_2)^2 -W(r_1)^2 - r_w \right] - \int_{r_1}^{r_2} W(r)dr [W(r_2) - W(r_1)]}{ r_w^{1/2}\left\{ r_w \int_{r_1}^{r_2} W(r)^2 dr  - \left[ \int_{r_1}^{r_2}W(r)dr \right]^2 \right\}^{1/2} } \right\}
$$
where $W$ is a standard Weiner process. Note that the usual limit distribution of the ADF statistic is a special case where $r_1 = 0$ and $r_2 = 1$ and the limit distribution of the SADF statistic is also a special case with $r_1 = 0$ and $r_2 \in [r_0, 1]$.

In the empirical analysis, we construct the critical values of the limit distribution by $2000$ replications of simulation.

#### Date-stamping Strategies

We follow the bubble period identification strategy proposed in PSY, which is based on the backward SADF test performs a sup ADF test on a backward expanding sample sequence where the endpoint of each sample is fixed at $r_2$,
$$
BSADF_{r_2 }\left( r_0\right) = \sup_{r_1 \in [0, r_2 - r_0]} {ADF_{r_1}^{r_2}}
$$
To date-stamp the bubble periods, we compare $BSADF_{r_2}(r_0)$ to the critical value of the sup ADF statistic based on $\lfloor Tr_2\rfloor$ observations for each $r_2 \in [r_0, 1]$. The origination date $\lfloor T\hat{r}_e\rfloor$ of a bubble is defined as the observation whose backward sup ADF statistic exceeds the critical value and the termination date $\lfloor T \hat{r}_f \rfloor$ is the labeled as the first observation after $\lfloor Tr_2\rfloor + \delta \log(T)$, where $\delta \log(T)$ is the minimum duration required. In empirical analysis, we set $\delta = 0.7$ which results in the minimum duration to be 1 month. 

To calculate the dates,
$$
\hat{r}_e = \inf_{r_2 \in [r_0, 1]} \left\{ r_2: BSADF_{r_2} (r_0)> scv_{r_2}^{\beta_T} \right\}, \;  \hat{r}_f = \inf_{r_2 \in \left[ \hat{r}_e +\delta\log(T)/T , 1\right] }\left\{ r_2 : BSADF_{r_2}(r_0) < scv_{r_2}^{\beta_T} \right\}
$$
where $scv_{r_2}^{\beta_T}$ is the $100\left(1 - \beta_T \right) \%$ critical value of the sup ADF statistic based on $\lfloor Tr_2 \rfloor$ observations. 

### Reference List

Diba, B. T., & Grossman, H. I. (1987). On the inception of rational bubbles. *The Quarterly Journal of Economics*, *102*(3), 697-700. 

Evans, G. W. (1991). Pitfalls in testing for explosive bubbles in asset prices. *The American Economic Review*, *81*(4), 922-930. 

Phillips, P. C., Wu, Y., & Yu, J. (2011). Explosive behavior in the 1990s Nasdaq: When did exuberance escalate asset values?. *International economic review*, *52*(1), 201-226. 

Phillips, P. C., Shi, S., & Yu, J. (2014). Specification sensitivity in right‐tailed unit root testing for explosive behaviour. *Oxford Bulletin of Economics and Statistics*, *76*(3), 315-333. 

Phillips, P. C., Shi, S., & Yu, J. (2015). Testing for multiple bubbles: Historical episodes of exuberance and collapse in the S&P 500. *International Economic Review*, *56*(4), 1043-1078. 