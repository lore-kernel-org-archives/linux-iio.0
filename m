Return-Path: <SRS0=Np4f=6O=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Tue, 11 Jul 2017 19:56:06 +0100
In-Reply-To: <CAL_JsqJa7JeofpG=66AnVrTP4XtVrp9B4-QoLTyK08GzF4L5uQ@mail.gmail.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com> <20170709165704.26311-9-lorenzo.bianconi@st.com> <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop> <20170711192656.7fd08a1c@kernel.org> <CAL_JsqJa7JeofpG=66AnVrTP4XtVrp9B4-QoLTyK08GzF4L5uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open drain mode
To: Rob Herring <robh@kernel.org>,Jonathan Cameron <jic23@kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <0462CB71-6762-48F2-99B3-EA62FF81C280@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 11 July 2017 19:42:54 BST, Rob Herring <robh@kernel=2Eorg> wrote:
>On Tue, Jul 11, 2017 at 1:26 PM, Jonathan Cameron <jic23@kernel=2Eorg>
>wrote:
>> On Mon, 10 Jul 2017 21:51:58 -0500
>> Rob Herring <robh@kernel=2Eorg> wrote:
>>
>>> On Sun, Jul 09, 2017 at 06:57:03PM +0200, Lorenzo Bianconi wrote:
>>> > Signed-off-by: Lorenzo Bianconi <lorenzo=2Ebianconi@st=2Ecom>
>>> > ---
>>> >  Documentation/devicetree/bindings/iio/humidity/hts221=2Etxt | 8
>++++++++
>>> >  1 file changed, 8 insertions(+)
>>> >
>>> > diff --git
>a/Documentation/devicetree/bindings/iio/humidity/hts221=2Etxt
>b/Documentation/devicetree/bindings/iio/humidity/hts221=2Etxt
>>> > index fca263e13400=2E=2E732b83c06c08 100644
>>> > --- a/Documentation/devicetree/bindings/iio/humidity/hts221=2Etxt
>>> > +++ b/Documentation/devicetree/bindings/iio/humidity/hts221=2Etxt
>>> > @@ -5,6 +5,14 @@ Required properties:
>>> >  - reg: i2c address of the sensor / spi cs line
>>> >
>>> >  Optional properties:
>>> > +- drive-open-drain: the interrupt/data ready line will be
>configured
>>>
>>> Needs a vendor prefix and "drdy-open-drain" would be more specific=2E
>> This is straight out of the pinctrl bindings and has been used in a
>few
>> other places as well=2E  I can see it should really be more obviously
>> associated with the drdy pin though=2E  A few IIO drivers already
>> use this binding (st sensors and the lsm6dsx)=2E  If we are going
>> to decide it's a bad idea we should deprecate those bindings and
>> add whatever we do here as well=2E
>
>Ah, okay=2E Then the description should have a  "see pinctrl=2Etxt" for
>the description=2E
Agreed=2E=20
>
>Rob
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
