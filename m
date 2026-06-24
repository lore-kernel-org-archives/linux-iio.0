Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2D3D9DD1
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314843; cv=none; b=SDaUhAu4ztvCeWsiXrT79iAFetnJyD/JdXoP3F2s23glG7UO7lkQM7A6TuF5vPXALEyWFWvwFtntW+fJazQ3+l1svcT3w3PSDS4KU+PUKA3/6tKBqp+f2ChLJqJnq8ELvlZfMbnJs1Zad3KNAmzxqVXjglSQPGxHOoX8MpNI8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314843; c=relaxed/simple;
	bh=zQlht0IsyQB1oNhNfYXgYgQbV1Y7rokfYO480Nk79qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLEZBsohyrzVCDzIdIpI/zSxhV8x38FaOTuytkfY52NTwybI9jGw73WDhQuUZcbMSHb4qq+ja58z8XdyN06kk7s9V1+/Bb+Lb7SNTBl7SfvnQFq2DAEtlF5pC71KFDnxF7/Z52LwioxgaNH1If3ucI+W+sBqMNghmj2dCgyb9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TVI+Qcdp; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TVI+Qcdp"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4472500e25fso593195fac.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782314840; x=1782919640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjq8lD80zO6HiyYMuWH6+pjiwlUb52f+5tf0ovQAwVM=;
        b=TVI+QcdpMI3gzRx7l3JLLLB5sQGg3piLry+GcCTA5BxoD+KBsB3tPvy4HxUpIHxhqK
         wSlAcvWsHnGKXG03VwM4A5aFP9xiyo+lB2WtFA6yWUS87wNocMowf3EOtiBHwEHcBHdu
         U2Ir1u4g1w02xirvTNygo+DjlkTI3RSntD7iIes520e35AS00NKB8jtqaccxMrAm+Y8X
         gC2OQ+gVV1inlg+5U/bPqKBT9KplfjhNOzBOLXjuW16lJdctd0mBgSppV3/9rbPARJh9
         H1x4/mi5msywP21t3cglyP/VQjWp+BAVJ4ytVvH+f2VApXP1bAMRz64HIOrf5h/UAlZm
         iiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782314840; x=1782919640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjq8lD80zO6HiyYMuWH6+pjiwlUb52f+5tf0ovQAwVM=;
        b=oM8onVY72uMACT/O1IgJ8W5d4bUguD5RTAdb6uJya8cudb1AZnHRrm8RdpBgeH8c+y
         8ZTB2I4xsna3GNNrOURFfOwMeYAqX2d1OARuzAR3DiXpQB9YxSGN9tbhUSgVGOSnZKxB
         3CvfHMft4TOgGPSFn1W8cbNKrTb8dLdhaUUkUw1YzjebPDgzMPiZwzbet+LSDt3jAR2B
         pEI91+v5aO7G0LZZddcGDCHnojm8DFTYDCzh3MmoymN7Y1ATYQFzmwtO0GvBPYKP/A79
         ZJAya1fYmJmSyOFoGvlpY4W9LmC6y04rSAauVivpwg2lWHxKYAeN9AxYqgQUNsFwdUgh
         f0Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9/eIp6Gforln8mFHXFcKq009JThrbX2O8oY+Hv7pjgInRjwiuHMmfcryy685SELegV1WWthF8R6jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevXfGxMohqQES6brBikznZGWrxds32TG5Nm5K/NJWBJuUJOPC
	kUmDhKfRvQEHnzzQuqahx7O9h/oJnlLnKA0GgCuXRznk9XoKILI+9Vr6JrB3xanT/WM=
X-Gm-Gg: AfdE7cl31cfNd+SSQFopAvApBbV2oFbOj090bXX5TAEHzfeTLMh2Spve+pxVOO0NmEm
	/bWR7c20WR1bHSu6LnveFNOxnD5F7F9cxxGoEpHue8h9h2Zpluat7NIJEXMJzsQzRxyjTawnoF/
	rqG4xeXvriSqnyTlpZfhJwkZM6EhPzp7sSgU6X47vCyn8WdV5rODfIeOG3MlwtDfp6wsJewpepM
	RgoP2+D0orSk8PUhNZ3I0RSvlZjuy+hPkthZjU7JnRJjGlrxxTS86mF3jvnShEOULyelk8m4mk0
	sSqvJgjUABY00vfns5DtnZp0RDKfWNopeMX3fHxO1GT9c9BlZIAxv2/ikO1pbC/KBWOK5jeDJip
	dS4hhf+exEsCB0TP3o+JOOiZEatkUKOBHyCL5brNJiBQvmDbyPfiWj3LfwSSiiObEXmHyS/FAFD
	OKBEbmBxwCFCwpC8+3zgm1klOAJHeosZudFvrCh2MPva/hsTRNq3fpfyqj+PbZPko=
X-Received: by 2002:a05:6871:7991:b0:42c:4c8:4a5a with SMTP id 586e51a60fabf-447dce9b4a5mr2572915fac.28.1782314840687;
        Wed, 24 Jun 2026 08:27:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec6065esm10933021fac.4.2026.06.24.08.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 08:27:20 -0700 (PDT)
Message-ID: <afebba8b-ec1e-4b91-a600-f4df0c576219@baylibre.com>
Date: Wed, 24 Jun 2026 10:27:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
To: Lukas <lukas.metz@gmx.net>, Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <ajrg62FtXNObGkmc@ashevche-desk.local> <ajvt5J5Cs5cOdTLt@berta-MS-7693>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajvt5J5Cs5cOdTLt@berta-MS-7693>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 9:47 AM, Lukas wrote:
> Thanks a lot for all the comments.
> 
> On Tue, Jun 23, 2026 at 10:39:23PM +0300, Andy Shevchenko wrote:
> 
>>> +		dev_dbg(dev, "%s: val=%d val2=%d\n", __func__, val, val2);

Trimming down the reply is good, but in this case, it would have been
helpful to leave a bit more context. I usually keep the full function
in a reply to have enough context if it isn't too long.

>>
>> No. Is it RFC? PoC? Or production-ready? If not the latter, come when it will
>> be production-ready.
>>
> 
> I will remove the debug print. I tried my best to make this driver production-ready.
> I saw that other drivers also have similar debug messages so i didnt

This one jumped out to both of us as odd because of the __func__ and the
fact that it is in a very common operation (raw write). Usually debug is
for catching odd things that happen, not normal things.

> remove it after my first tests and thought it is ok to leave it in
> there. My intention was to try to apply the suggestions and comments i
> get and send a second revision. Do you think thats the right way?

Yes, you are doing it right. For a new driver like this, it is best
to wait about a week before submitting the next revision to give ample
time for review. Your replies so far where you think a suggestion was
wrong or have asked for clarification are spot on as to what we expect
for the review process.

