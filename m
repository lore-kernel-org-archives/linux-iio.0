Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EAA32F74D;
	Wed, 28 Jan 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624853; cv=none; b=GyCTwCAFdeUWNdBYbxWK5xxaQYf9Q5/8duVNZFGthPQmYF1K3RHX8SUA7sO2KCXSGuBAvovsGpvR/mj/n01vMx6r0qSTASOSLRhpiic1OSOu6dhADX9DieQVuCu1tQb6tD24ik+taTN9EIFTSRMPwLmT0v7bcLoVaM2Et+CJA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624853; c=relaxed/simple;
	bh=u+jLxQtMq2LBVoKtT7Fqb11e0RvC9Sv5nZxtFCXBYwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDcOtP60UzHr5L4F8/tjPB5ntOOeFxpgSjvB8Y0V+zrFyjAjQqB3SJQ/CCHaMIZYRcY9fRJa0yidu4m57Dw1TGETuwoK8LCYqhBCr4aVgUM8JUJAx86r91z2gKzAgCrpjlsLqHhYXHAr1UgBHnv8PhVQOjy1Rh2FJlfxbh5IzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EYc4H9pM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EYc4H9pM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=uF4kmxtjGHntKBXEs51aUkE0oN5YUm3uaHjWpyoexdg=; b=EYc4H9pML8N3yDqbPF6RMDIBYK
	xiuci3inS72NPDzttU/KEA4/N8ZIUM+Kd6W7rcJjM3y7fgsiIZheRFTXcVt4WBy7kO8zGvQIUz9Ms
	Zd8eC0UjQEQWlWgF3K+KWIZ9dO4ZteE6fDML2KQrARdPczKfyF5T8nbaBIPbsLxvEh41ylUFsFdlj
	2ov87MwWzYtzWcUvbwtP38ub5ZB6vwnDLx6cSPfLrjs0xNWiDouGJmADvZWHzwRZEMmYzxsvsPLMU
	tXqIdfPprOziuA7JqlL0Kzg3P426th+X3fNdFsGLujz+xueDOLKVGK6+o6GPCKHH9fMUB0n/qhBnt
	GamTPoxw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlAGF-0000000GcVq-223b;
	Wed, 28 Jan 2026 18:27:27 +0000
Message-ID: <0598bfa4-fb8c-495e-875c-4ad7a724cd83@infradead.org>
Date: Wed, 28 Jan 2026 10:27:26 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: buffer: buffer_impl.h: fix kernel-doc warnings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
References: <20260128062550.405473-1-rdunlap@infradead.org>
 <aXnaa-VfaL8ozVJb@smile.fi.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aXnaa-VfaL8ozVJb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/28/26 1:44 AM, Andy Shevchenko wrote:
> On Tue, Jan 27, 2026 at 10:25:49PM -0800, Randy Dunlap wrote:
>> Resolve all kernel-doc warnings in buffer_impl.h:
>>
>> Warning: include/linux/iio/buffer_impl.h:172 struct member 'direction' not described in 'iio_buffer'
>> Warning: include/linux/iio/buffer_impl.h:184 No description found for return value of 'iio_update_buffers'
>>
>> Also correct one typo (word order switch).
> 
> ...
> 
>>  	/**  @bytes_per_datum: Size of individual datum including timestamp. */
> 
> Shouldn't we also delete here...

Yes, that's the oddball in this file.
I could adjust that...

> 
>> -	/* @direction: Direction of the data stream (in/out). */
>> +	/** @direction: Direction of the data stream (in/out). */
> 
> ...or add here an extra space after asterisk?

Negative.

-- 
~Randy

