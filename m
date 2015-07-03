Return-Path: <Thomas.Betker@rohde-schwarz.com>
In-Reply-To: <559431B0.6050304@gmx.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <1429125111-2926-4-git-send-email-thomas.betker@freenet.de> <558DCA63.6040001@gmx.de> <OF4F435CFE.EBD383ED-ONC1257E74.00350661-C1257E74.003C1F9E@rohde-schwarz.com> <559431B0.6050304@gmx.de>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] iio: adc: xilinx: Fix VREFP scale
From: Thomas.Betker@rohde-schwarz.com
Message-ID: <OFAADB8E4A.20F38E2E-ONC1257E77.002AF662-C1257E77.002B36C5@rohde-schwarz.com>
Date: Fri, 3 Jul 2015 09:52:00 +0200
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

Hello Hartmut:

> > I would suggest opening a webcase with Xilinx for clarification, and 
> > adding another patch for VREFN if the factor 3 is confirmed. Can you 
do 
> > this? If not, I can take care of it, but it may take a while as I am 
> > pretty busy at the moment.
> > 
> 
> Go ahead, whenever you find the time. I don't have a Xilinx device, just
> reviewing the IIO patches and got a bit curious when reading through the
> data sheet.

Okay. I have opened a service request with Xilinx; let's see what happens 
... (:-)

Best regards,
Thomas
