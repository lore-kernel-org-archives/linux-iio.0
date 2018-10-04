Return-Path: <SRS0=aPR5=MQ=chromium.org=dianders@kernel.org>
MIME-Version: 1.0
References: <20181004001432.21218-1-mka@chromium.org> <20181004001432.21218-2-mka@chromium.org>
In-Reply-To: <20181004001432.21218-2-mka@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 4 Oct 2018 08:14:37 -0700
Message-ID: <CAD=FV=Xhic45SCQSVx0XXgtcyFAMEmOt97HUKZjHa_nyd4Ur2A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-iio <linux-iio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Wed, Oct 3, 2018 at 5:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The node has a reg property, therefore its name should include a unit
> address.
>
> Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> DT conventions.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index d0c188e5c922..ff7aa5038ba6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -112,7 +112,7 @@ Example:
>                 io-channel-ranges;
>
>                 /* Channel node */
> -               usb_id_nopull {
> +               usb-id-nopull@VADC_LR_MUX10_USB_ID {
>                         reg = <VADC_LR_MUX10_USB_ID>;

This is my understanding of how it should be done and matches some
existing examples I see in the tree.  AKA "pd_hdcp@RK3399_PD_HDCP".
Thanks for cleaning it up!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
