Return-Path: <SRS0=QfiP=6J=gmail.com=robherring2@kernel.org>
Date: Thu, 6 Jul 2017 13:55:44 -0500
From: Rob Herring <robh@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: iio: tsl2x7x: add of_match table for device
 tree support
Message-ID: <20170706185544.dhhwfh3c7f6cerbp@rob-hp-laptop>
References: <20170629170352.11264-1-masneyb@onstation.org>
 <20170629170352.11264-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629170352.11264-2-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 29, 2017 at 01:03:47PM -0400, Brian Masney wrote:
> Add device tree support for the tsl2x7x IIO driver with no custom
> properties.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 10 ++++++++++

It's better if you split this so I can take it and avoid any conflicts.

>  drivers/staging/iio/light/tsl2x7x.c                   | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
