Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170621204050.75863dd5@kernel.org>
References: <1497374443-20935-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <20170618140511.kz6nvttypockcrfm@rob-hp-laptop> <20170621204050.75863dd5@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Jun 2017 22:05:13 -0500
Message-ID: <CAL_JsqKDAPOqRepjRU9qrZQ-8_01JAfckP7G1EAjJi4t2UK7kg@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: humidity: Add bindings for HTU21
 and MS8607 sensors
To: Jonathan Cameron <jic23@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	William Markezana <william.markezana@meas-spec.com>, ludovic.tancerel@maplehightech.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 21, 2017 at 2:40 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 18 Jun 2017 09:05:11 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> On Tue, Jun 13, 2017 at 10:50:43PM +0530, Manivannan Sadhasivam wrote:
>> > Add device tree bindings for Measurement-Specialties HTU21 temperature & humidity sensor and humidity part of MS8607 sensor
>> >
>> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/iio/humidity/htu21.txt | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/iio/humidity/htu21.txt b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
>> > new file mode 100644
>> > index 0000000..97d7963
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
>> > @@ -0,0 +1,13 @@
>> > +*HTU21 - Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor
>>
>> The binding should be for the device, not part of it. You should bind
>> to a driver for MS8607 and then create 2 child devices for the humidity
>> and temp sensors.
> Hi Rob,
>
> It's a bit of an oddity as we are look at package in package parts.
> Really there are simply two parts here. There is no need to know
> they are in the same package.  Obviously we 'could' describe this, but
> it's no different form  mounting the chips next to each other on the
> same bus sharing the same power rails.

Okay, then it is fine as-is.

Rob
