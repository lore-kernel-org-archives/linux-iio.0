Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670408;
	b=f4BHy0unynXp/vcjrvGnQoer0GVmbJTrmOjQHaiQRFV5ua5k9lF0IgzIWn0ZbPXPj7Hf
	 f17tEpAbbOzZiM1xVXPVTGnc8fCM8/ss8dJTyhYp76E3QB2dUPtz41+cZQrM73HEQrDis
	 UW7jvTfue3I3NiR6yV5QeJlHmpKEjFrvrMmkNuhuT6QcMxloamWsFMBTuGTmMN6lC78hb
	 AtNQ+sdH/u+glXMMJ25bSgG70v00LtSVpDzf7cdG/n5pyKCYFIzyG1INpv2k7Tdqk7nBa
	 o7w1RgLjd4a6m451QJANN5OSTr84c+9Ln4YQiafbhdZB+jO73Mo1ZIbq2o1+oAoOlUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670408;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fob9kSng6mp4bXAAY5OeSYhjqvoUqSfN2M5U/41nx+4=;
	b=41dPXhy2fSHbsIt6uIh5tUkLOjL1+RzdxJ6OQuCjn9HLOPBc/3bre+Che0DP2BlCIlp/
	 SlrjhtPZOVF4qFt9DBKZi+b/Csv08BqBrssmoj1vdPkYg6qXOiMEAI1tqessGE7y0JBwu
	 1GUyl4DynhJy5sRYPW2nXy1+FZYbMT9wu3eXGl7KeHWUCpyVo+SYN4HMoY1wgcYwaa/lO
	 u1yJ/+Q6Hq/JBw5angVE3JWJXJNVeM/fOJeSMus8JACFbqUq4mznYaySoFCdPri5e6W4e
	 aPXSaVsn1AJn7IScOsXLEDcSB5Cpodl0ykZue+pTT065oBunuwbJl870pvaE3EWGLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaD38Ba4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1051606A327;
	Sat, 14 Nov 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaD38Ba4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF8F1F000C5;
	Sat, 14 Nov 2026 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670408;
	bh=Fob9kSng6mp4bXAAY5OeSYhjqvoUqSfN2M5U/41nx+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YaD38Ba4m5FiQpx6VkdfLWBx4xs3Fb4e7nONc1FGZdG4OQeeunuLyZs0MDLNVx1HR
	 sdhuLkwxNRlZHjz8PFdW1ZqDCOLQCzPCXVdvtR16TFja18OuSx5NHwy2rccKjDUpox
	 4AicBxQFN3U3DSXmx41J6n7XUO6TH1J32Hbi3LNq8ZlhvmEc6yxwnbVs/3u9huecNr
	 MvJMbuRd4wl8C2v+IbqSN5uf3jVa4jpXVLaQir4j5TTxxd1RE912JhVwYq8rZU4p15
	 gcbOemy5ZtdYAXrGixy37mCRgfODCY3mjBpq4BaQIG1DW918sKkJoVUt9G/pDoP88d
	 kioSyuJV77BLA==
Date: Sat, 14 Nov 2026 16:33:20 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261114163320.4f92319e@systembl0wer>
In-Reply-To: <SN1PR12MB2528B9901C2150B1B89ED4DFA57E2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <20261113014849.06ab464d@jic23-hlaptop>
	<SN1PR12MB2528B9901C2150B1B89ED4DFA57E2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Fri, 13 Nov 2026 20:33:21 -0600
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> > Applied to the testing branch of iio.git.
> > 
> > I'll let the bots poke at that for a few days at least before
> > pushing out as togreg which linux-next picks up.  
> 
> Yay, first patch merged! (^_^)
> Thank you and Andy for all the reviews!

Impressive for a first patch series :)

-- 
Kind regards,
Joshua Crofts
