Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50115 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdEHL3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 May 2017 07:29:22 -0400
Date: Mon, 8 May 2017 14:27:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] iio: adc: Add support for TI ADC108S102 and ADC128S102
Message-ID: <20170508112707.GI2697@lahna.fi.intel.com>
References: <9d7366c4-7965-d92a-e806-f20a8d63242e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d7366c4-7965-d92a-e806-f20a8d63242e@siemens.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 08, 2017 at 10:46:43AM +0200, Jan Kiszka wrote:
> This is an upstream port of an IIO driver for the TI ADC108S102 and
> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> included.
> 
> Due to the lack of regulators under ACPI, we hard-code the voltage
> provided to the VA pin of the ADC to 5 V, the value used on Galileo and
> IOT2000. For DT usage, the regulator "vref-supply" provides this
> information. Note that DT usage has not been tested.
> 
> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
> Todor Minchev <todor@minchev.co.uk>.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
