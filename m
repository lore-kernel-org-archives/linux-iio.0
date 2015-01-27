Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] staging: iio: adc: mxs-lradc: Change type in printf format string
Date: Tue, 27 Jan 2015 23:59:58 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Darshana Padmadas <darshanapadmadas@gmail.com>,
 Aybuke Ozdemir <aybuke.147@gmail.com>,
 Vaishali Thakkar <vthakkar1994@gmail.com>,
 Robert Hodaszi <robert.hodaszi@digi.com>,
 Brian Vandre <bvandre@gmail.com>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <1422397413-9447-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397413-9447-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201501272359.59011.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Tuesday, January 27, 2015 at 11:23:33 PM, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Makes sense, thanks!

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
