Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602A391510;
	Mon, 23 Mar 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263511; cv=none; b=GIMCZurAOBd8DVydVKT3a9CvmDMKLszceRIFtuo3okkii/kYaoAkXu14NTTsiLr9icgmPxtwHLUUW4eOhu3k5+5/018Nn5Bhdlu0d0aYyqjV+IqdYPhrSzKFgMJiJApHwk6eGE6U6w0sOU0n8HJ9iH8T8NGDBUb14F2BrSq3tbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263511; c=relaxed/simple;
	bh=9KbO74I12O/7ACgir1GdiXPjp0B8qZTU7hfI8FXQDls=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqDZKvJnB123iaztlf7oiBUTBFT4a3fOMFpmpnGYS1n83SWUxvLKT1yAMj+AERKP0E6rPveYcoYiLY5T57VgvmuHMa4gr7+6seRsYm9I9RiC3rEiOTsLZVJRUPik1VTEZVtG6utUYI/AELoZ7D4IZcJ94hUlWbOp21YJhBQt4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffVWQ2JrdzHnH96;
	Mon, 23 Mar 2026 18:57:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DC0240587;
	Mon, 23 Mar 2026 18:58:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 10:58:24 +0000
Date: Mon, 23 Mar 2026 10:58:23 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260323105823.00003183@huawei.com>
In-Reply-To: <20260321100154.1258-1-antoniu.miclaus@analog.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sat, 21 Mar 2026 12:01:50 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).

Given the lkml cc this got picked up by sashiko:
https://sashiko.dev/#/patchset/20260321100154.1258-1-antoniu.miclaus%40analog.com

Mixed bag on correct and (I think) incorrect stuff but take a look and fix
up anything you agree with for v8.

Thanks,

Jonathan

> 
> Architecture notes:
> 
> The AD4880 is modeled as a single IIO device rather than two independent
> devices because the channels share power supplies, a voltage reference,
> the CNV conversion clock, and a single interleaved data output stream.
> Splitting them into separate IIO devices would make synchronized
> dual-channel capture impossible from userspace.
> 
> An MFD approach does not apply here either - the channels are not
> functionally distinct sub-devices but identical ADC paths sharing a
> common data interface.
> 
> Each channel has fully independent configuration registers accessible
> through separate SPI chip selects, so per-channel regmaps are used with
> no locking between them. The data path has no software involvement at
> runtime: the CNV clock triggers simultaneous conversions and the device
> outputs an interleaved bitstream captured directly by the IIO backend
> (FPGA). spi_new_ancillary_device() handles the configuration path;
> the IIO backend handles the data path.
> 
> The debugfs_reg_access callback is not exposed for the dual-channel
> variant since the IIO framework provides a single (reg, val) interface
> with no channel parameter, and exposing only one channel would be
> misleading.
> 
> The AD4880 is a fairly unique part - having separate SPI config
> interfaces per channel with a shared interleaved data output is not
> a common pattern.
> 
> Changes in v7:
>   - Drop debugfs_reg_access for dual-channel AD4880 variant
>   - Pass struct device * to ad4080_properties_parse() instead of
>     using regmap_get_device(st->regmap[0])
>   - Use 100-column limit consistently for function signatures
>   - Add architecture summary to cover letter (per Andy's request)
> 
> Antoniu Miclaus (4):
>   iio: backend: use __free(fwnode_handle) for automatic cleanup
>   iio: backend: add devm_iio_backend_get_by_index()
>   dt-bindings: iio: adc: ad4080: add AD4880 support
>   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
>  drivers/iio/adc/ad4080.c                      | 231 ++++++++++++++----
>  drivers/iio/industrialio-backend.c            |  59 +++--
>  include/linux/iio/backend.h                   |   1 +
>  4 files changed, 273 insertions(+), 71 deletions(-)
> 

