Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0136.outbound.protection.outlook.com ([157.56.110.136]:65445
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751087AbbHTGuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 02:50:55 -0400
From: Duan Andy <fugang.duan@freescale.com>
To: Sanchayan Maity <maitysanchayan@gmail.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "stefan@agner.ch" <stefan@agner.ch>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
Date: Thu, 20 Aug 2015 06:50:53 +0000
Message-ID: <BN3PR0301MB121977040608F337E69ADADEF5660@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <d556443a26070be505f9a5f5f0999253b73d9b71.1439283162.git.maitysanchayan@gmail.com>
 <9be567ec7d6f6370dd42a41438d64cf7aaa47635.1439826018.git.maitysanchayan@gmail.com>
In-Reply-To: <9be567ec7d6f6370dd42a41438d64cf7aaa47635.1439826018.git.maitysanchayan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Sanchayan Maity <maitysanchayan@gmail.com> Sent: Monday, August 17, 2015 11:52 PM
> To: jic23@kernel.org; linux-iio@vger.kernel.org
> Cc: stefan@agner.ch; Duan Fugang-B38611; pmeerw@pmeerw.net; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Sanchayan
> Maity
> Subject: [PATCH v4] iio: adc: vf610: Add IIO buffer support for Vybrid
> ADC
> 
> This patch adds support for IIO buffer to the Vybrid ADC driver.
> IIO triggered buffer infrastructure along with iio sysfs trigger is used
> to leverage continuous sampling support provided by the ADC block.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
> 
> Changes since v3:
> Fix iio_buffer_setup_ops for postenable and predisable functions to match
> pairwise. Before this the predisable work was being done in postdisable.
> 
> Changes since v2:
> 1. Fix the wrong buffer size for statically allocated buffer 2. Drop the
> use of .address field from the iio_chan_spec 3. Use iio_buffer_enabled
> call inside the lock 4. Drop wrapper function around iio_trigered_*
> function calls 5. Drop Kconfig select of sysfs trigger 6. Drop Kconfig
> select IIO_TRIGGER as it is already selected by IIO_TRIGGERED_BUFFER
> 
> Changes since v1:
> 1. Use a fixed size buffer instead of kmalloc allocated during update
> scan mode 2. Remove a write to read only register ADC_HS (COCO bit)
> 
>  drivers/iio/adc/Kconfig     |   2 +
>  drivers/iio/adc/vf610_adc.c | 105
> +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 100 insertions(+), 7 deletions(-)
> 

The version is fine for me. Thanks for your effort.

Acked-by: Fugang Duan <B38611@freescale.com>
