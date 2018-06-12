Return-Path: <SRS0=EtZl=I6=gmail.com=robherring2@kernel.org>
Date: Tue, 12 Jun 2018 12:21:33 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, Michael.Hennerich@analog.com,
	lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, mchehab@kernel.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	linus.walleij@linaro.org, rdunlap@infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180612182133.GA3118@rob-hp-laptop>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
 <20180610145923.3b767ad4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180610145923.3b767ad4@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 10, 2018 at 02:59:23PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Jun 2018 16:11:05 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Hmm. The first part number I've ever googled where the top hit has
> been a flight number. 
> Rio de Janeiro to Campinas is apparently on time today.
> 
> > ---
> > Changes in v2:
> > 	- Nothing changed, just to follow the patch set version.
> > 
> >  .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 85 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > new file mode 100644
> > index 0000000..75fff6c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > @@ -0,0 +1,84 @@
> > +Analog Devices AD5758 DAC device driver
> > +
> > +Required properties for the AD5758:
> > +	- compatible: Must be "adi,ad5758"
> > +	- reg: SPI chip select number for the device
> > +	- spi-max-frequency: Max SPI frequency to use (< 50000000)
> > +	- spi-cpha: is the only mode that is supported
> > +
> > +Optional properties:
> > +
> > + - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
> > +		   The following values are currently supported:
> > +		   	* 0: DC-to-DC converter powered off
> > +			* 1: DPC current mode
> Perhaps expand those acronyms?
> Dynamic Power Control  and perhaps a bit of explanation so people
> who are ready DT files don't have to go find the data sheet to have
> some idea of what these are?
> 
> Otherwise, binding is fine.
> 
> > +			* 2: DPC voltage mode
> > +			* 3: PPC current mode
> > +
> > + - adi,dc-dc-ilim: The dc-to-dc converter current limit
> > +		   The following values are currently supported [mA]:
> Unit should be in the name.
> adi,dc-dc-ilim_ma

Yes, but don't use '_' and follow what is in property-units.txt.
