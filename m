Return-Path: <lorenzo.bianconi83@gmail.com>
MIME-Version: 1.0
In-Reply-To: <0462CB71-6762-48F2-99B3-EA62FF81C280@jic23.retrosnub.co.uk>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-9-lorenzo.bianconi@st.com> <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop>
 <20170711192656.7fd08a1c@kernel.org> <CAL_JsqJa7JeofpG=66AnVrTP4XtVrp9B4-QoLTyK08GzF4L5uQ@mail.gmail.com>
 <0462CB71-6762-48F2-99B3-EA62FF81C280@jic23.retrosnub.co.uk>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sat, 15 Jul 2017 16:32:35 +0200
Message-ID: <CAA2SeN+2T2-G1khRNpNzccesX=cip0ConT11RJRV-HB8Ojk0pA@mail.gmail.com>
Subject: Re: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open
 drain mode
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo BIANCONI <lorenzo.bianconi@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

>
>
> On 11 July 2017 19:42:54 BST, Rob Herring <robh@kernel.org> wrote:
>>On Tue, Jul 11, 2017 at 1:26 PM, Jonathan Cameron <jic23@kernel.org>
>>wrote:
>>> On Mon, 10 Jul 2017 21:51:58 -0500
>>> Rob Herring <robh@kernel.org> wrote:
>>>
>>>> On Sun, Jul 09, 2017 at 06:57:03PM +0200, Lorenzo Bianconi wrote:
>>>> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>>>> > ---
>>>> >  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8
>>++++++++
>>>> >  1 file changed, 8 insertions(+)
>>>> >
>>>> > diff --git
>>a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>>b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>>>> > index fca263e13400..732b83c06c08 100644
>>>> > --- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>>>> > +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>>>> > @@ -5,6 +5,14 @@ Required properties:
>>>> >  - reg: i2c address of the sensor / spi cs line
>>>> >
>>>> >  Optional properties:
>>>> > +- drive-open-drain: the interrupt/data ready line will be
>>configured
>>>>
>>>> Needs a vendor prefix and "drdy-open-drain" would be more specific.
>>> This is straight out of the pinctrl bindings and has been used in a
>>few
>>> other places as well.  I can see it should really be more obviously
>>> associated with the drdy pin though.  A few IIO drivers already
>>> use this binding (st sensors and the lsm6dsx).  If we are going
>>> to decide it's a bad idea we should deprecate those bindings and
>>> add whatever we do here as well.
>>
>>Ah, okay. Then the description should have a  "see pinctrl.txt" for
>>the description.
> Agreed.

This property has been defined in pinctrl/pinctrl-bindings.txt. Is it
fine to refer to that file?
Regards,
Lorenzo

>>
>>Rob
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
