Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083624;
	b=mNp7weA0N4NNoz9KWH4RN8IJN6SsyHDL8I9V89XWgWjHOzIwihdDK58hQCMprFOrpE4K
	 espWI3L8sx3T0dWZFyY60wiqvqSStzjAxfKAhKmGQe/uFA+W/m1E8D3Sh3syiilP6/oZA
	 UB22Iu+4S/XncI+OS4MqQV/arNRYVtQK1H/pvyTHelNPER6N7Z9zV6cHOdag5ecfZRfbd
	 1VKJE1uPk4mKxrlouGjN9CVFx5UgrbGoEqFX7/K3gEQH9ShZrP64ntMTgJOR/qTEz8j3O
	 oj34+chZKt1KamCMp6xXdEnbRSifwU+TRY9AVBPB5fFJ0Md6QvmqYDfOB2CmtrGRV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083624;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=kMLYuvKF8dKdiwmDA59a1qSto363i7DFLCqovWncpVM=;
	b=gh0vV8+MyXSDXhUK+QH1I3WPeChM2Xd9+t3S6xis3gr0bXp5BDDMhy5hgz5kv4V1K31p
	 Lyt5jx61U7S/jg2g11XnFQOe7OFYslxqkxLURjYZ0/1o5rD56wFNertakWskVrfGvrvmh
	 VqDtpnLoAiNxFwO8z/kZTgxyRvIirtYe8tFjNqR7W6u9WWxkKtWVhOp4rkY6qoU3Piq+B
	 iuBu0lZFRq8grMXFkqfrNbBBV3KvDeWR/8EgGWGZjw+92iqBGg26km6KkdMxguU9nGe/V
	 wa2xBpyKZ36XZL4xB6lgwbpul5XHFFD4bDddSLdpXj8WtPVjuO4JFt/hjqxKZ5uvCVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wrFrTipr;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28759606A325;
	Thu, 19 Nov 2026 10:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28759606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wrFrTipr
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jVZGq6rjlzMm1S;
	Thu, 19 Nov 2026 11:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795083620; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMLYuvKF8dKdiwmDA59a1qSto363i7DFLCqovWncpVM=;
	b=wrFrTiprp0Ygwj7fisQqKLfMWazzJwQS8HPNFqbCcn3xMC23c+XlYnmWGpPY6OwTsCFYcG
	pjdBV2XlPMgXizD5IHA860ywzUkD+zPnBEGC3P1iYty0h7dFnuiza4M6w6o0En4MdrFa29
	+z8/8pstoFJyzCxAaLcosYSfYnFvqRobT36nmnUt0/xlqfaGVRZ2fcD0Ifm0zgDEtu/5+n
	P8Q5PrjWKULrK0PMh7Putf64gTqx4d0cgQar9yKkwd/OUN6051FoFULV5Tr2btX33lJYti
	3up4UWipIuXn1wiDtyGvTg7fYqQDSjJUVFutoAn1IjQz0zTDogOUfQ0NPiL7ZQ==
Message-ID: <11c1451c97fa27ec3379965d13a6eea64e386cc3.camel@mailbox.org>
Subject: Re: [PATCH v2 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri
 <sunil.khatri@amd.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike
 Liang <Prike.Liang@amd.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  David Rosca <david.rosca@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal	 <mcanal@igalia.com>, Raspberry Pi Kernel
 Maintenance	 <kernel-list@raspberrypi.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Thu, 19 Nov 2026 11:20:14 +0100
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: e0df46cc69f1b87359b
X-MBO-RS-META: 4qqptwxqro4tns8nyafutn165yabqokk

On Wed, 2026-11-18 at 14:45 +0100, Philipp Stanner wrote:
> Philipp Stanner (3):
> =C2=A0 dma-buf: dma-fence: Add flags parameter to dma_fence_init()
> =C2=A0 dma-buf: Port users of dma_fence_init64()
> =C2=A0 dma-buf: dma-fence: Remove dma_fence_init64()

Applied to drm-misc-next with the Rbs.

Thx guys.

P.
