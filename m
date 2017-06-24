Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUu7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:50:59 -0400
Date: Sat, 24 Jun 2017 21:50:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        William Markezana <william.markezana@meas-spec.com>,
        ludovic.tancerel@maplehightech.com,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: humidity: Add bindings for HTU21
 and MS8607 sensors
Message-ID: <20170624215053.615f8a2c@kernel.org>
In-Reply-To: <CAL_JsqKDAPOqRepjRU9qrZQ-8_01JAfckP7G1EAjJi4t2UK7kg@mail.gmail.com>
References: <1497374443-20935-1-git-send-email-manivannan.sadhasivam@linaro.org>
        <20170618140511.kz6nvttypockcrfm@rob-hp-laptop>
        <20170621204050.75863dd5@kernel.org>
        <CAL_JsqKDAPOqRepjRU9qrZQ-8_01JAfckP7G1EAjJi4t2UK7kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Jun 2017 22:05:13 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jun 21, 2017 at 2:40 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 18 Jun 2017 09:05:11 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >  
> >> On Tue, Jun 13, 2017 at 10:50:43PM +0530, Manivannan Sadhasivam wrote:  
> >> > Add device tree bindings for Measurement-Specialties HTU21 temperature & humidity sensor and humidity part of MS8607 sensor
> >> >
> >> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> > ---
> >> >  Documentation/devicetree/bindings/iio/humidity/htu21.txt | 13 +++++++++++++
> >> >  1 file changed, 13 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/iio/humidity/htu21.txt b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
> >> > new file mode 100644
> >> > index 0000000..97d7963
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
> >> > @@ -0,0 +1,13 @@
> >> > +*HTU21 - Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor  
> >>
> >> The binding should be for the device, not part of it. You should bind
> >> to a driver for MS8607 and then create 2 child devices for the humidity
> >> and temp sensors.  
> > Hi Rob,
> >
> > It's a bit of an oddity as we are look at package in package parts.
> > Really there are simply two parts here. There is no need to know
> > they are in the same package.  Obviously we 'could' describe this, but
> > it's no different form  mounting the chips next to each other on the
> > same bus sharing the same power rails.  
> 
> Okay, then it is fine as-is.
> 
> Rob
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks Rob for getting back to me on this.

Jonathan

