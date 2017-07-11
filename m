Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932506AbdGKSnQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jul 2017 14:43:16 -0400
MIME-Version: 1.0
In-Reply-To: <20170711192656.7fd08a1c@kernel.org>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-9-lorenzo.bianconi@st.com> <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop>
 <20170711192656.7fd08a1c@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Jul 2017 13:42:54 -0500
Message-ID: <CAL_JsqJa7JeofpG=66AnVrTP4XtVrp9B4-QoLTyK08GzF4L5uQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open
 drain mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        lorenzo.bianconi@st.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 11, 2017 at 1:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 10 Jul 2017 21:51:58 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Sun, Jul 09, 2017 at 06:57:03PM +0200, Lorenzo Bianconi wrote:
>> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> > ---
>> >  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>> > index fca263e13400..732b83c06c08 100644
>> > --- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>> > +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
>> > @@ -5,6 +5,14 @@ Required properties:
>> >  - reg: i2c address of the sensor / spi cs line
>> >
>> >  Optional properties:
>> > +- drive-open-drain: the interrupt/data ready line will be configured
>>
>> Needs a vendor prefix and "drdy-open-drain" would be more specific.
> This is straight out of the pinctrl bindings and has been used in a few
> other places as well.  I can see it should really be more obviously
> associated with the drdy pin though.  A few IIO drivers already
> use this binding (st sensors and the lsm6dsx).  If we are going
> to decide it's a bad idea we should deprecate those bindings and
> add whatever we do here as well.

Ah, okay. Then the description should have a  "see pinctrl.txt" for
the description.

Rob
