Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171241;
	b=rD5+egpZKePcOkfdXqmCTAsbs2Ck8F3lta5joPmD1CK1GhemXA4uBipkvZHOBOGDGQnv
	 iwZYCEp/3cFl3hqcPjzywBN4IsF58rqPSRLuQyVzQXfki1Gu9oMf9OQ/Oew+3y5ise4eZ
	 m7W7tEPUwEf2EwvX1PzOPMeQHyygwmuv7a1VAhM1l03oKDdOLPBBv/sYZF5+9lhMLmQAW
	 rsj2mEycDX7kATc9epB5cJR2SdNIHbPhM3I46No6lqZA4lVTZvPRGjDIjW2xLNW+01lWd
	 CJ2fPWvVrmhf7ZbTf9ezW/Y5HrP7ufXDtURunVmz+DJETYdFtxrd0IV7sY/rhu92WEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171241;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DVRsJ9wq4tXbtq2igL6w/DBYxGcOEDyi4Dh9KPPuNiw=;
	b=4lBNUq8KfhF7la04fid07ybPZuLnUN9B0mMxS+i3gOuHCnaeSWaKuNnyOSmw85qaj+Bw
	 cWnAPwNXxIYGyV5XM10s3Y6+JDVzGIcqb2gi72QpjGOeY3ihHAIWw3pkI1bs1x3BVMQUx
	 AjigaDtgPcltxOQbeIGpdxkDIfOUE1S7j0dcuSIaUrZ8jbcBWP+njn0/O3+sjuHtAGdGz
	 5Kk8aVzpYytX1e3LsEVhYXpUe0Z0ohOCMqm+Rve9xfWnKNeil4GF9kAjACYJYAfYcGkUQ
	 Ew0LUi73SaOHrncMJOZuWZR0bNu6wLumVVDBm8ui0Im3GklGUad71l1PYkod4dBYcEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9YSdON2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D360A2615
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9YSdON2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97761F000F2;
	Fri, 20 Nov 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171241;
	bh=DVRsJ9wq4tXbtq2igL6w/DBYxGcOEDyi4Dh9KPPuNiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d9YSdON2oDvDuIuded5hL+4n59KBykiA6dWB0T0lvVzmwWB4i5ZU5AI/k1u5Pqgke
	 HIH83tIPE7jjaS+XEk3djqbs/tns5vZIYA6UclOLSYkmELqU+WsE2KhDCJ6NgICceB
	 zonBULQ/a38P0tr/2Okmn3IpYm5q0tmtDiLY2ZfpdjzlgbTIVvBotRAVz4JR/lAuD0
	 5y0PknP8INftdkfKrag8QpyjGgErTovT0uire4mW3oINaBzJlx6pIwvs9327M8jise
	 xKvzooYeoFsYb7TAniEYhvyXakYYkHLKccMiDsYU9b2M3ECcCJCoCNHZYOQXR+n/Fs
	 Q8NHd+IokYabg==
Message-ID: <93a78ecd-d6c5-40a6-8236-d7d380f8ae54@kernel.org>
Date: Fri, 20 Nov 2026 11:40:35 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: iio: Close attribute streams on parse errors
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Cc: zhujun2@cmss.chinamobile.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, knaack.h@gmx.de,
 linux-iio@vger.kernel.org
References: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
 <20261120074417.33563-1-aleszlucero@gmail.com>
 <awAZnuq2XAGo5De-@ashevche-desk.local>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <awAZnuq2XAGo5De-@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2026 10:57, Andy Shevchenko wrote:
> On Fri, Nov 20, 2026 at 01:42:39AM -0600, Oscar Alejandro Sánchez Lucero wrote:
>> 
>> I checked both paths in build_channel_array() and find_type_by_name(),
>> and confirmed that neither cleanup label owns or closes the open FILE
>> stream on fscanf() failure. Closing them before jumping to cleanup while
>> preserving the original error code looks right :)
> 
> But the change has flows when errno == 0 after the system call.
> 

Interesting how suddenly there are now two patches fixing IIO tools.
tools/iio usually doesn't see much activity...

-- 
Kind regards,
Joshua Crofts

