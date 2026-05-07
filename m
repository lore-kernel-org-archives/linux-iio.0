Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DF7083C
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119943; cv=none; b=CshIwR/MRIHlZdwfKZeLuMd3HS3ap1w7V9vvLSJBNg9fVBk+Y4YeGSmhI0pgU1EKtpuTazPq1TvN40HI8NuJAZFA1x8+QDgB4AdF49wvOprgimfaav+qOaXr3NbRsOk1JyN2LJCJ5fEgrop6BGZevo2nLHpbWyU5phVUVqpMZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119943; c=relaxed/simple;
	bh=Jn0IQQl2f4ofPH+JuObEQweEqxGZ6jBdB4+BIoFLxjI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DEL35fTs2LOmCB21GPNjdMz7DX/o7UiW+pNZjz7gOpRRG0ZI84176QoA9UIFYFk7tDggh48pwEPjZwet39gHEQucL5xCg01sWQuk8pPsGSQqZ11SPFkBTOSx5VNRgkozkPFxUbJ/fgrmzALJaXg4zjcYQc4yGgn4whwEUC87+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYt47IIZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYt47IIZ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83659d38e38so96796b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778119941; x=1778724741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jn0IQQl2f4ofPH+JuObEQweEqxGZ6jBdB4+BIoFLxjI=;
        b=RYt47IIZfF894UNQ5R4vCn1x1COzYqdxr/ajWkC/qDXqraNWVYPPKLmGXAlovvtSH2
         ZmgPXDNlz3v2rGqjF/RDET9O+g97D3vjxQAyI73EmN+JjLV1lVsp0gkcO54WMpyq1LFt
         H4nehjONR57LNoPpiNGaweNepDX+/7oZ+QzN/VFyFA+CnULWr/Kj5h79paya9/uPtxkA
         742pww+bMwe6xLzOOkguk1N0NMCG3xnqMl67Y1RLuYIUjQyKmhAbtgtHmYL2rFDf4yc0
         a5AxPJqFL7EDWBHU3yV7d6aGnfSQcLLVzPrlaXAP78xJe823lnZTohDO+euolaE/x8zP
         X+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778119941; x=1778724741;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn0IQQl2f4ofPH+JuObEQweEqxGZ6jBdB4+BIoFLxjI=;
        b=KxRQE5+yFcDr9Y3fOBdJYNucsbEArinDzaZY4j6wdxyQQTsPaE+DzfL4kVXkcC7Wc3
         vypEAbR3dGrMjhy8Pn3QhWVOMTpYEKUq2KIH7MiPTNYSMnhS4VkJIHv+t1MW8YyBHU5a
         QNrHXsYoeFk1mgvSesSoVK1mr5oqm0wwO4CL0eKXnAgrOUqKCaj9KVkMYQH4s82s8tQR
         lyJknRNHF2zKBRAyM8N7wmQSxHFe0/ZTWrKAdb/CCkl2OBIlBWMzBeUlxie/i22jc98F
         +ubNnUpaiuBhuAifCzUTpNAImAnUY6g60lHGcWF/mJTYnEzjiG8YaSNgSw0VWXvtQ7zm
         uplg==
X-Forwarded-Encrypted: i=1; AFNElJ8ERQh913G4b52BW3xhqVdDGHPUSV6zRDzZKy4Eu/NLsglbGp4XuVCBXsoK08VUJVIEZb5K9RCMcRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wvLNAIsRXZlTIdY/yDjx89lisIQSBZvf7VBNz+VrfNCgZgOw
	NqLIa5mQ9QuGS0ZoxuFkj5DWh9xWdDmpMEvMxy8VbbTWfLiHwcIEdafp
X-Gm-Gg: AeBDies1x2gtqSlGrpmcQ7ltOaU+4Tt6DMEsBk3KmE0MPPNRt7+73Qd+K+K47Mmyaix
	dx0aNIxQB+GRgSKEqNlwGOmHAMUEQ0m6NGZ2uHF1YOJOJbT1pl3FGcK5v1sfuD/qFrZtlXefJL9
	bxr6f9DW5/LD1MrCGg/eBkV7akBPFeGHc7cCvs8Dm4mKGe6pwGBJgWDfSmMgZpwhhamIRNaUO77
	xSFI46evGrlNqdpPNtlj1nASCUOiJzF4+/heraRh9uy88yZO0+pZMfqOqTXXAmGOcEnxyfGL9zc
	v5xXTwqXcx2NZMl8A7GrKjc8/ch68GqcZ4OlMCoTrxZiNZcaUaxuIKbjk9DSXLZ+Gm2ajmyfnyq
	eA0XpaYagpCxRec8BtHh/6xcl0ws46mjg78vNr8UzOqskTnonylUmZbMvkPKC5U98cS8U9ImfD4
	TA8+dqRqU3gZmDB4IJ+MB2SRQaHeR1ebdwun6elrBM1VCL7/qvWJLwJGYarOUl4CafLLb/
X-Received: by 2002:a05:6a00:3e0d:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-83a5e249732mr5321453b3a.43.1778119941172;
        Wed, 06 May 2026 19:12:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac23:b594:789f:a6c4:c581:db80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d38ab5sm8365567b3a.26.2026.05.06.19.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 19:12:20 -0700 (PDT)
Date: Thu, 07 May 2026 07:42:03 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_00/10=5D_iio=3A_accel=3A_mma8452=3A_i?=
 =?US-ASCII?Q?mprove_coding_style=2C_pm_and_resource_cleanup?=
User-Agent: Thunderbird for Android
In-Reply-To: <afsI6hyCHghRUOz1@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <afsI6hyCHghRUOz1@ashevche-desk.local>
Message-ID: <904844AB-191B-492C-8238-5C94134250DD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 May 2026 2:54:58=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevchenko=
@intel=2Ecom> wrote:
>On Tue, May 05, 2026 at 11:16:30PM +0530, Sanjay Chitroda wrote:
>
>> This series contains a small fixes, cleanup and improvements to use
>> modern kernel helper API and coding style for mma8452 accel driver=2E
>>=20
>> The changes modernize mutex with guard(), dev_err_probe usage,
>> resolve checkpatch CHECKS and pm_ptr macro usage=2E
>
>=2E=2E=2E
>
>> Feedback and reviews are very welcome=2E
>
>Sorry I haven't asked this previously=2E Is any part of this analysis / c=
ommit
>messages / et cetera AI assisted?

I have used AI assistance to prepare initial templates for cover letter an=
d commit message guidelines=2E

However development is done by me and I refer git history of similar contr=
ibution to prepare commit message=2E

Additionally, contribution and development is done as part of LFX mentorsh=
ip program under the guidance of Shuah Khan and Brigham Campbell where AI u=
sage is strictly restricted to commit message templates and review=2E

>
