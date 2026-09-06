Received: from crab.ash.relay.mailchannels.net (crab.ash.relay.mailchannels.net [23.83.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5717D6;
	Sun,  6 Sep 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788686655; cv=none; b=Ki0nZVWbO+HWmKvdfcTNrP5qhjAClYW1mo77WbL9jBOp+3sISsBJn67i5FUArmkorT3MmEFDMpz/uvh0DNG3DGMCL01dw6H7GQ9GsOmnjAljTkE9hJB/3YUKJfYV9qvCWe+FHJ62Zx4GyF7RaRmlIOyWJWyoyRkg75DWA8Ef6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788686655; c=relaxed/simple;
	bh=4JQb+a2INDVDiwVOjBoGI4kupU7ObpyIx86IjEot0cI=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=ZLiWEZ5AIOu8HoP+mQyrc8U6kcc/tE36JTu1xPimoWq0H5+stD3Ayekh+EayZUODtF0uau677Cln6pqJPs/upybBh/niaSoODW4C5fy6psu2EccrSlWU626croOCl7up1omhJRS4lE1YfbcCfJCymTaDKvI40zIk4CLH/H8WSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com; spf=pass smtp.mailfrom=tunakilic.com; dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b=fqgC8EKH; arc=none smtp.client-ip=23.83.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b="fqgC8EKH"
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DC0D440247D;
	Sun, 06 Sep 2026 09:08:14 +0000 (UTC)
Received: from de-fra-smtpout4.hostinger.io (trex-green-9.trex.outbound.svc.cluster.local [100.96.233.231])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1ECE94018C8;
	Sun, 06 Sep 2026 09:08:08 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|tuna@tunakilic.com
X-MailChannels-Auth-Id: hostingeremail
X-Battle-Skirt: 21d37a6c620a3d76_1788685694746_947322632
X-MC-Loop-Signature: 1788685694746:4211412293
X-MC-Ingress-Time: 1788685694746
Received: from de-fra-smtpout4.hostinger.io (de-fra-smtpout4.hostinger.io
 [148.222.55.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.233.231 (trex/8.0.2);
	Sun, 06 Sep 2026 09:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tunakilic.com;
	s=hostingermail-a; t=1788685687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JQb+a2INDVDiwVOjBoGI4kupU7ObpyIx86IjEot0cI=;
	b=fqgC8EKHlbVvgLvxXZo/QWdD61QeSX5Jy16v1vtMRTUCAxPEmqOWA0NzLoUKjaMjvjS8Xy
	zzsonADYo2vac03X4v9WTGfg9nZHtxErMcPISXr/U3t2B+R40+5I1sPM6X1LTw98sPqXBp
	0+KTgiKeJPC61w8wA5DGj/MugUdxSI9Qii+0CLGbysLHjDpJBp+UpSWUcK0XNMI8nKHCFj
	DD0zrlkPRFY5U3HjJuMBDfjuEkRZRsjyNAm5OIOkouaDq9YAjexhIuB4DU/Rrk/CXdZr+g
	M2iHRtYA/Vdo5O+fQ3evEWDMJDdlqfxAxxR959gYiFXxQHC/pIm7Uj3te3LeZg==
Received: from tuna (unknown [IPv6:2a02:e0:7474:c000:e0e7:b2f0:b492:96fe])
	(Authenticated sender: tuna@tunakilic.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4hd49f49Vjz431V;
	Sun,  6 Sep 2026 09:08:06 +0000 (UTC)
From: =?UTF-8?q?Tuna=20K=C4=B1l=C4=B1=C3=A7?= <tuna@tunakilic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260906090802.1282585-1-tuna@tunakilic.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906045428.4f03494b@jic23-huawei>
References: <20260906045428.4f03494b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Sun,  6 Sep 2026 09:08:06 +0000 (UTC)
X-CM-Envelope: MS4xfE3pT8SH7lUwNkr7zJWG9/2bV5nbqZ4AURAqZqFUsoSILjZnp9WtJbXmoLB8Ie7JBVWmVg/y+lux3iv3he7fqgR502kJ1eqa+OnUCydoaRq8/pVhaMl8 fgPQ2MR80T2GShIdC1rluKAlJCJu1YJ6B9IAREb+gy5mVsrSY2J3vJ2EBgdtvpStxokuC+yKyZJOBaGZSx3sY531neuvXBc81yLwYwMIfeY/5ipPMKp8iR/T bfqa1OKUmBYaRprvK9t9tiGh8rTinoloF2Mtqtr8QiryaKCTH58bORJUUg3thHpAituqrG6eYZqcYG8INpK8dgPplWOHLKnxgoG5B7mQM1x2JwkoJdNqC7RQ sBvzTzJy18yL4oPB5lpkXHM/WtPfBzLkPo7MVi6jWhln7+aRqiaUAzt6zko09aGukiwV4pEPv5EcZCelloSoi5+ISPG/rA==
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=6a9d2d77 a=g35c8EtFT/OoTG0W9QvO+g==:617 a=xqWC_Br6kY4A:10 a=M51BFTxLslgA:10 a=Fx9MBwLTq3MFzORUWwgA:9
X-AuthUser: tuna@tunakilic.com

> If AI had anything much to do with generating the patch then
> a tag for Assisted-by: LLM is appropriate.

AI was only used afterwards as a sanity check for the datasheet,
in_range() semantics, and the final patch. The bug and fix came from
manual review.

Thanks,
Tuna
