Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080214;
	b=kJGmoX06kW+ToyZMCsw2QSLpC//dDei9kkbD2v+4p4NaWZQYLmMoPL3+BO5JR3KQlifS
	 tPpvEHR2k8GEPkHxvJFaE/A0VQOEgpx/+P/RFhLpacDY8fEVOjf4vjbOZwUI2qgzAPDxA
	 iViik/RragkZP2+wOYKsjc77ceYM/JPNi4zOWVu8cH3ohhEPH6QvwCN/HPyoiBc2XkbnR
	 NV9ccnBnPWTMTadj+Q1qFjVZo3Ss7609oRD5A3Zdpsvcw4Srea9MCCuZ1si7WO5kTCNtj
	 iH2RtcGTO7ISvdYOqcpcJK/HFMqVPDn5zDPaLty3ivhGdQ5sa5EnJG2xIJ6VFxFxMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iw+1heiK2ICDcPw8wxaIild6GuXV7caep89ksdPkeww=;
	b=WTNUhjdsd6wXQ2JNqE2ufPDRDXA1F06y2pUg1dMMXBa7L5oN6fe5AH+Vj44Pu5DlTOzl
	 kWWDcHyOyp+Ko4YXL46giIpSu/Z2/dJM84CDdgaeImpLWEB/vMCBE/LfZ24+pw0kiQps0
	 2qbfhFXb4uzc0gwQf6lFhcvAcCr+bQ/DW5zdNpyUeHfrAHEgeizfz2zLMQsUgKikQ0P9a
	 qSIDwzbg7l+jvSGMDZKuhJ1Hv9/YgjY0CXYahDra9xgVnspGhmc56WAaIsGG8kpGFeUeI
	 5XprOQeyW6r6WewsxBpASj+CE+vwxk+CoZr0K8O+9XSu2fobKjx/oZW8zYnjRqjnwbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Od3btkl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272C606A326;
	Sat,  7 Nov 2026 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Od3btkl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC70E1F0089F;
	Sat,  7 Nov 2026 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080213;
	bh=iw+1heiK2ICDcPw8wxaIild6GuXV7caep89ksdPkeww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Od3btkl6/wuE37gEAgaHX2++GQPdV8zbwMsvi17hiYXv7I1IhoV7oSgsMQWbngCac
	 qNNNKhDlmZwmVcLaTOtMaWWP05LqXUBOHNDA7mlMfP8vc32Bqd7kmFw/T25N+LppRc
	 rdDD717995SxmlJQpoO6LofoKlhRwNKRPjNN06aHWHyDZNd8b7geATAoSPCeyZaZ3p
	 9UQagCiTqDUoJhy1V7AUVfIBq/pjJPOsIDRinvkKk5QkbNP1iCmoe6g+hHHv5t1D/U
	 9wGglqS0EV97CWZOg49CXIBaWrgn8MqQuHuqSx1SG/CBlCRw7h7x1BObF+XJLibZDp
	 qmAWDURJTPrHw==
Date: Sat, 7 Nov 2026 19:36:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261107193648.24413159@jic23-hlaptop>
In-Reply-To: <SN1PR12MB2528BA7C696815089DCAD02FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528805DB17DD015E191111FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB2528BA7C696815089DCAD02FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 09:40:29 -0600
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.
> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
I took another read through and didn't spot anything else.
So fingers crossed for v6 after you fix those sashiko warnings.

If there are some you disagree with that aren't obviously garbage
(which is less common by far than it was) then reply to this thread
pasting them in with appropriate context and say why they are wrong.

Thanks,

Jonathan
