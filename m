Return-Path: <SRS0=EtL3=NK=gmail.com=robherring2@kernel.org>
Date: Tue, 30 Oct 2018 14:37:18 -0500
From: Rob Herring <robh@kernel.org>
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Carlos Iglesias <carlos.iglesias@emutex.com>,
	Javier Arteaga <javier@emutex.com>, Dan O'Donovan <dan@emutex.com>
Subject: Re: [PATCH v3 1/3] iio: adc128s052: Add pin-compatible IDs
Message-ID: <20181030193718.GA5566@bogus>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
 <1540481742-23596-2-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540481742-23596-2-git-send-email-dan@emutex.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, 25 Oct 2018 16:35:40 +0100, Dan O'Donovan wrote:
> From: Javier Arteaga <javier@emutex.com>
> 
> The datasheets for ADC122S021 and ADC124S021 list two more
> pin-compatible alternatives for each device.
> 
> Add their IDs as compatible strings.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt        |  9 ++++++++-
>  drivers/iio/adc/ti-adc128s052.c                          | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
