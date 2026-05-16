Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2123E325
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929458; cv=none; b=IUtXHLAdz4Z9nOQhNARbAJLxKMqn+uTW7kxA8E4wuEcGTkVmAjsM1QvD9XkDYIOzUo5PYgZSg4v7laJ7kzthxhTQ3JYdJ8mKeEkvrdx9xnFRdmeoIMguPl313fwWtkQXh62a4n8vqc2Wfe3ObrxgHJlbHoOe4rv/z7foEn5frL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929458; c=relaxed/simple;
	bh=ShHzOwIepnoht6KiDhIktqWbm/o3Vwx6B0RA+PQohtk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u3rM90INSDq6kjxD/c+PxDpU6i5g0UjKpxVmzK8DqENSNryQwAz3gR5ZoL+JiXARxLiFfsQBPrqRRdwWbjPVHk+UADxWJ48FqX9Ui2p7G0RBPZSDojMMVQShinhC9jtkb4tzb/aoYHd7GSJJRY/e5tUjQQq8UIW1YCIobz8EtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+mFIQlP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+mFIQlP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48896199cbaso5032705e9.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778929455; x=1779534255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CgxlGI2RJ/TxMcYutFk4DspmNHfrDImny4KkfuqlQkY=;
        b=j+mFIQlPjbDUsoKMXfrIPw3rfrTLcemNHCR5pMWsg8vw3Epj2Dio35PmXLJyQtcFGz
         k5Jcubu9xlpQYA11z/3VsJ+qrnjMge8PcWQGkMt5HLd0YfrDx/cSl2l7naQccrmCIVTY
         JekHtuhGsGDSwBvm5ugISJHfvLN7kI6GXqAlqPrlbD3VingLmN8zFfPMxHOHgbNySUx6
         9w5jig0yEYIFD/3U1ENAcCk+o5ZWbak3+ME8tUxbTov06CZPTi+wyEKSCtvHNWk8WrSs
         VDkq1joh9KdP7QZUMkUbBHpDLOwsDRrv/FyValVdU/YiIhu0gY7S5q1tmTxpwILQnlPX
         f+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778929455; x=1779534255;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgxlGI2RJ/TxMcYutFk4DspmNHfrDImny4KkfuqlQkY=;
        b=EtjIza6C5U1OIicL4IgU82pYixwz5B1h5mzcQUB1H5cOB4pfRls5Zlzr63gpsk4paa
         S5HFqzwFQVXf44TkM/9Ma0xDcoIBqcXAolZLpJtyBVEmx8RLg27XSNHhWErDO2qOhaQ6
         LIq8sEvOHyudzGstI+8kGTM2w5QQRWJopNZYMS34r2QWpcix1aHKx0dWqHaPQmyyGfC1
         KT2mm5PECEveXoVvpcihMM5wwnDWJm+CRc44ulIo8mvG3QtPShO6mpvwpjXCUVsGt9lP
         Ko8GvRGPJ5Rg3dlD1wvxtIZR6egPDM+La1mMnQlL9zbYttGt3JBI1i9JOUTuXztsIEhU
         MEyA==
X-Forwarded-Encrypted: i=1; AFNElJ96XdlCAnrXhUFL75+OtH6fJ4N3BIPkKBf4dN1/O08R+oJzYypXRukFHuoY3/AMlOikI8qCcXwQWMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40duXBQLp6w40bXhg4eTz24o0sdsqn+1kg139dgdRVZ2i2kq0
	MyCUPTutjS0RiPKjJHmYiJfw7CXThGcenXmFwyNEiLxaXnaqE64ln788
X-Gm-Gg: Acq92OHC9igWqhVxse1ndeBw4CPbOhtxINLTM9MFWN+hc1dVjEmHGAU1hit+PXMZ/p/
	JHgzGDhpnhlJcNf3bLlR3TJoD04R3uk8ICEaPck5/R61uWtQ6+3XU3dhOjlG2j3nyzLEqFIE0Tx
	E+7e3afjFjMvi2Hs4V+7EHTJLLHWW96AcQVVz/xO/XcS2f+vfzEhBDWRvzkejT6f9ry9YRcoKw4
	IYN1cvby4Fa54gfOFS9iSIJRo++R5fiKWT+JEKgnuRd2oFaBiQJxEAWlcL97IDvm7LAnTmkShG+
	WweOxB6zeZRdaREiO6a4R7ZQQBlYSJMtXYa5aHKyBM34u+qWl/dSlSbvFp6An9NAZ5+InIgZv5f
	FSsKjXCVt5OyEotwEfHco02ReLVa9WOCXnoFIkvEd/nkirfuQm9sWIb/uB7RxCKuyPtogvq1u+8
	p1K9SuPUi74v2dTHO1MfahO2OZXbaebkwg8BbXB/jtLg/fm0lDOT76wOBEYvKGitcRkPmX4aQ=
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr5855755e9.7.1778929454853;
        Sat, 16 May 2026 04:04:14 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm21338399f8f.20.2026.05.16.04.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 04:04:14 -0700 (PDT)
Message-ID: <1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
Date: Sat, 16 May 2026 13:04:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Aldo Conte <aldocontelk@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-6-aldocontelk@gmail.com>
 <agRfMWL9BughLT2x@ashevche-desk.local>
 <36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
 <agS70Dph8-zQT-e6@ashevche-desk.local> <20260515190517.70bb0ba5@jic23-huawei>
Content-Language: en-US
In-Reply-To: <20260515190517.70bb0ba5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/05/26 20:05, Jonathan Cameron wrote:
> On Wed, 13 May 2026 20:58:40 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> 
> I would add for this that, to reduce churn it's fine to add the
> struct device *dev = ... bit and use it in new devm calls. Just do the
> remainder in the follow on commit.
> 
>>
>>
> 

Hi Jonathan, Andy and all!

Thanks for your reviews! they’re teaching me so much!
If I understand correctly, I need to wait a week before submitting version v3 
such that other reviewers can comment right?

I’d like to take this opportunity to suggest two alternative lists of what 
version v3 might look like in terms of patch order:

First option does not consider the "== NULL with !" patch and so:
1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
2. iio: tcs3472: sort headers alphabetically (same)
3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
4. iio: tcs3472: use devm for resource management (slimmed down)
5. iio: tcs3472: use locale struct device * for remaining cases (NEW)
6. iio: tcs3472: implement wait time and sampling frequency (revised)
7. iio: tcs3472: move standalone return to default case (same as v2)

Second version will consider it:
1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
2. iio: tcs3472: sort headers alphabetically (same as v2)
3. iio: tcs3472: convert several functions to use guard(mutex)() (modified)
4. iio: tcs3472: replace == NULL with ! (NEW, optional)
5. iio: tcs3472: use devm for resource management (slimmed down)
6. iio: tcs3472: use locale struct device * for remaining cases (NEW)
7. iio: tcs3472: implement wait time and sampling frequency (revised)
8. iio: tcs3472: move standalone return to default case (same as v2)


What do you think?


Thanks,
Aldo
