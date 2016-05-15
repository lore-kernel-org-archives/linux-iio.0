Return-Path: <lucas.de.marchi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1462929938-15910-1-git-send-email-matt.ranostay@intel.com>
References: <1462929938-15910-1-git-send-email-matt.ranostay@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Sat, 14 May 2016 23:14:19 -0300
Message-ID: <CAKi4VAKCLe_UvuPVEQUB+qXZMvd4N4ai2z6LjG28oDf5xOe9pQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: add support for ADS1115 part
To: Matt Ranostay <matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Tue, May 10, 2016 at 10:25 PM, Matt Ranostay <matt.ranostay@intel.com> wrote:
> TI ADS1115 is a 16-bit resolution ADC that is register map
> compatible with the ADS1015 device.
>
> Cc: daniel.baluta@intel.com
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---


I see no changes to the available data rates in ads1115 which are very
different from the ones in ads1015. Am I missing something?

Lucas De Marchi
