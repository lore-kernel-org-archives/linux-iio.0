Return-Path: <robherring2@gmail.com>
Date: Mon, 31 Oct 2016 01:06:55 -0500
From: Rob Herring <robh@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
	knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Mark.Rutland@arm.com
Subject: Re: [PATCH 01/10] staging: iio: tsl2583: add of_match table for
 device tree support
Message-ID: <20161031060655.xhugdvrvuhzu4xjl@rob-hp-laptop>
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
 <1477648821-3786-2-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477648821-3786-2-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 28, 2016 at 06:00:12AM -0400, Brian Masney wrote:
> Add device tree support for the tsl2583 IIO driver with no custom
> properties.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../devicetree/bindings/iio/light/tsl2583.txt      | 26 ++++++++++++++++++++++
>  drivers/staging/iio/light/tsl2583.c                | 13 +++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.txt

Acked-by: Rob Herring <robh@kernel.org>
