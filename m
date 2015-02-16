Return-Path: <lee.jones@linaro.org>
Date: Mon, 16 Feb 2015 13:54:21 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, david.woodhouse@intel.com,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, todd.e.brandt@intel.com,
	jacob.jun.pan@linux.intel.com, sameo@linux.intel.com,
	dwmw2@infradead.org, jic23@kernel.org
Subject: Re: [PATCH RESEND v3 1/3] mfd/axp20x: change battery cell name to
 fuel gauge
Message-ID: <20150216135421.GJ14545@x1>
References: <cover.1422909564.git.todd.e.brandt@linux.intel.com>
 <94002239142b80ddd090f39325c9adaa17c9da9f.1422909564.git.todd.e.brandt@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <94002239142b80ddd090f39325c9adaa17c9da9f.1422909564.git.todd.e.brandt@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 02 Feb 2015, Todd Brandt wrote:

> Name changes to the battery cell structure to a
> more generic cell type: fuel gauge.
> 
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Acked-By: Sebastian Reichel <sre@kernel.org>
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/mfd/axp20x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> v1: 01/07/14
> v2: 01/22/14
> - replaced the const in axp20x_acpi_match declaration
> v3: same as v2

FYI: Changelogs are usually placed _above_ the diff stat.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
