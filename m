Return-Path: <SRS0=JtcQ=3L=gmail.com=robherring2@kernel.org>
Date: Mon, 3 Apr 2017 10:54:25 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5 v3] iio: xoadc: augment DT bindings a bit
Message-ID: <20170403155425.fmmstdwfacmnsn7w@rob-hp-laptop>
References: <20170330080541.4065-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170330080541.4065-1-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 30, 2017 at 10:05:41AM +0200, Linus Walleij wrote:
> In order to accommodate in a logical manner for the premuxed channels
> in PM8921 and the similarly addressed channels in later PMICs, we
> need a twocell arrangement with premux and analog mux setting as
> a tuple to uniquely identify a hardware channel.
> 
> These bindings are not yet in use, so it should be fine to augment
> them before we actually start using it in drivers and device trees.
> 
> This scheme came out of lengthy discussions and reverse-engineering
> and reading of the few information sources we have.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Suggested-by: Björn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop leading zeroes on unit addresses.
> ChangeLog v1->v2:
> - Name nodes with <01 02> in a foo@0102 pattern.
> - Minor spelling nits.
> - Delete flimsy leftover docs from an interrim development path.
> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 76 ++++++++++++----------
>  1 file changed, 42 insertions(+), 34 deletions(-)

Other than the few typos mentioned,

Acked-by: Rob Herring <robh@kernel.org> 
