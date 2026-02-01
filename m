Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C0163;
	Sun,  1 Feb 2026 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769972621; cv=none; b=p5x5Zc7AX8FEukzbVHxoRgDtAxcHjdBc22fEehRO+mcDyELH8r5+zXhU09QIjvczaQNA/r6mfgZLhOAvzeGxleKoFLRE/5PaRTvGH96PmkMXbSdLr9dktblcorG7Y6t7h66JgsqLlSx9JSC6Qyi7Ujm0/wI0AjhDHDvMF/rglJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769972621; c=relaxed/simple;
	bh=BKdUwsqpefF4P2K/a3UELdB2MeRgMQvR10OQLm5Id3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i69aDn+cqdpMMp0VFX94SziWoJqWmHuptp2Qw8HGrXrm+d/9NlMNSonGUWon3vii+86Nh2zQEyoKBdzucuQ6gCXLHWj4f9xMiKs9rpyzGGL01Y03rJYsRdfwqgr5V7BQXNdtPtAeudaNM9hdBooBBwaEITAIpf6lit2yufexIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kAoCrfLS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kAoCrfLS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FoIwwqhKIiHnQPW4ts6TTeEy6x1NqAY5UI5OwHrle3I=; b=kAoCrfLSt4u1SDDSoPk5DW/qNQ
	GA4g5LaHJi1bsl2qwGQ761ZD5D79GLcoEC5qurJP27JQzk+nUJGmVBXXw47vDk1orRdvLsw3Cucco
	1SYLR/NcoF0tz7RNMyfoFKbCO673U6P4GhMubBH+0Tt5iefLFWL7Sm4YyJQ5y4f0kOo63dXcnICYs
	krwahmIYa3DTogauWx1XhbIN+TYDS0uV2KAQ/ETbaybqAYGouK3wxStMafuOvozgh9P9yYx9Uh40r
	7Qx1qrnCxTN8jnDbI7k9hrEwiyKguFDqf8eedaaY42KiY0Mh1mhn7SH5eDeDazGLda4ZywEGNj1R7
	vKgfqTDA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmcjM-000000046IH-0P1j;
	Sun, 01 Feb 2026 19:03:32 +0000
Message-ID: <6cee15c9-13d4-44d9-bbb2-4a7a53fe23f2@infradead.org>
Date: Sun, 1 Feb 2026 11:03:31 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] docs: iio: adxl345: fix typos and grammar
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, jic23@kernel.org
Cc: me@brighamcampbell.com, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
 <20260201183320.27023-2-0rayn.dev@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260201183320.27023-2-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
I have one little nit here:

On 2/1/26 10:33 AM, Taha Ed-Dafili wrote:
> @@ -78,7 +78,7 @@ Specific IIO events are triggered by their corresponding interrupts. The sensor
>  driver supports either none or a single active interrupt (INT) line, selectable
>  from the two available options: INT1 or INT2. The active INT line should be
>  specified in the device tree. If no INT line is configured, the sensor defaults
> -to FIFO bypass mode, where event detection is disabled and only X, Y, and Z axis
> +to FIFO bypass mode, where event detection is disabled and only X, Y, and Z axes

As an adjective, I think that "axis" is still correct here.

>  measurements are available.

-- 
~Randy

