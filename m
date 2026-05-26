Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1A405874;
	Thu, 28 May 2026 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992224; cv=none; b=oJe/HvFPWZzx6bvjaXs1bOtrFqdpWbEAb44z996sGIWbTNczvlhOQ6ri+FnbuQ+Gbndjna+R+0UD7MQrZiJdHmyItdBbym47S3zxw8igyWao+pwHNY2oMkjuo7hG+TWbOJ85Rq0ctf4sIBeSjBx+HVriCFtgVsga7dNsGfOFtfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992224; c=relaxed/simple;
	bh=XIQcvOBQXSJQG9HR8DWFxF8nLSMI5kIUwd8uYnkI5qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltZU4VA8VN5YGVBkinvSsuqknBHQowWKtC9v5KrdYnUojsdatB21iWKP6E2p9VIi0v410KiSWfwC3JFz3mY2HR30kvDarUMif3nYF8dMgavLkyHFCeL6to7aZV+nBls9HQQHyM4K5kkjc7XFDfYj7++oav8JYO/OS25tjS7n7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=Wna63snq; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="Wna63snq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=XIQcvOBQXSJQ
	G9HR8DWFxF8nLSMI5kIUwd8uYnkI5qA=; h=in-reply-to:from:references:cc:to:
	subject:date; d=al2klimov.de; b=Wna63snqri5jcaDlRpl+EGnHep6rSNpuosf/Nx
	CwB++DwvOmJaU5xSlojEckepo9c5mAnQkVR+0YKkz3lVgKK1ST6N5n5T+UMZAicB9DMezG
	WFIWqJt8nH2fCR5V2E3wiLJ88Z86zsbi34fWKI/uzWJi5UY38Q76VCjRDv5qRjc0x6Fz5o
	iW1b1n67yKoluXYaTgW/+UkxS3Nx4rHL3ME8oWdy4+pTajH+8yBW0m+f3fNJLN17q9t49V
	Trypnx4UfQaYz6uxf86N2Qq8KNDiwef3yth9tyn0U8968qUxGpVqRgqmPdGWCACIy5Zlm/
	prloa5+FFaUsgunGfEnk25rQ==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 7fe9a56c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 28 May 2026 18:16:53 +0000 (UTC)
Message-ID: <f14307bd-060f-4d5a-b7ac-20e9f096463d@al2klimov.de>
Date: Tue, 26 May 2026 20:14:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: al3320a: read both ALS ADC registers again
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 David Heidelberg <david@ixit.cz>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260523114505.73601-1-grandmaster@al2klimov.de>
 <20260523114505.73601-2-grandmaster@al2klimov.de>
 <20260526155249.1028be2a@jic23-huawei>
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <20260526155249.1028be2a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/26 16:52, Jonathan Cameron wrote:
> On Sat, 23 May 2026 13:44:58 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>> al3320a_read_raw() used to read two adjacent registers
>> until the driver was modernized using the regmap framework.
>> That cleanup accidentally replaced the 16-bit word read
>> with a single byte read. I'm reverting latter.
>>
>> Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> For future reference, be careful not to send new threads in reply to
> old ones.

You mean I shall send v2 in the same thread as v1?
Strange...

"please make new threads for everything you send"
  -- greg k-h

https://lore.kernel.org/all/2026052249-shrank-trophy-14ff@gregkh/
