Received: from fuchsia.ash.relay.mailchannels.net (fuchsia.ash.relay.mailchannels.net [23.83.222.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE69488237;
	Fri,  4 Sep 2026 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526277; cv=none; b=J9iKN7XdQhyNYApW0TYwAiwr38KQ4g3NEU+/CAbBePQxI87dRjUZqYt31dP4UaEn2GvCQ4BY7Q+NuZAlgIWObgKIf5w+5MlKcVqWrwJXpD/PT3qPwg6NCMW+mWec4aH/WEWSH5ymprJU0TQm2h547tK31x8jIIcKvruiBT7JHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526277; c=relaxed/simple;
	bh=9drcvL3fh4EMFv/DH218MKHZCJhadIOxFhozHd73JOw=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=gPGa6R3fNnRTI51aCST/tAm9n8clU1MgTFIy84d4Slxa9DqePl7hH2173m5IZg+IliYhx+lWLESZNBRDF+e+N12/2ZvCUAPVlZ6rpfYzkr6eOjvwzqVZnTUFGP0OFJ06m/+LB4TQnn4s9dXmgu3uOP1YQLMoY90dsDvyXH+El7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com; spf=pass smtp.mailfrom=tunakilic.com; dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b=ZxDm+mlQ; arc=none smtp.client-ip=23.83.222.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tunakilic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tunakilic.com header.i=@tunakilic.com header.b="ZxDm+mlQ"
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7F3D4461903;
	Fri, 04 Sep 2026 12:51:08 +0000 (UTC)
Received: from de-fra-smtpout4.hostinger.io (100-98-23-243.trex-nlb.outbound.svc.cluster.local [100.98.23.243])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E6639461AD6;
	Fri, 04 Sep 2026 12:51:06 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|tuna@tunakilic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|tuna@tunakilic.com
X-MailChannels-Auth-Id: hostingeremail
X-Snatch-Irritate: 669564620e22f1b2_1788526268322_3904756084
X-MC-Loop-Signature: 1788526268322:576418007
X-MC-Ingress-Time: 1788526268322
Received: from de-fra-smtpout4.hostinger.io (de-fra-smtpout4.hostinger.io
 [148.222.55.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.23.243 (trex/8.0.2);
	Fri, 04 Sep 2026 12:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tunakilic.com;
	s=hostingermail-a; t=1788526265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9drcvL3fh4EMFv/DH218MKHZCJhadIOxFhozHd73JOw=;
	b=ZxDm+mlQdKbsxhZgldPzyoifiLXAyXY6YZkhVwQ6fIFHrGm2jRJgFjlYMMWP1QL9NP8JsB
	k0NOUoGGJmyQNkqePuLSZBLV0D2T0rSkA/fqenXxZqZoDv8cGr9o1VBj+Je0UBbOyjUJuy
	nbD2e4zG/H9uza34fc4bqdO4Ns7VZBjfIvqPiYGGBPcWXUNmNuff7vAVk5UC2ChQBnNPqp
	f3rBM10ukRQSJcSAEWGXcRJ36a2nLtZcPRusKVv0/NHEz1oGttiQH6sxuM87RIDlc/kVuH
	HOkvSRluQFwloIFw92ftDgiQbITOkZuB3CnGAjx+ciiTMwE0ExQP0+XsGgQ/AQ==
Received: from tuna (unknown [IPv6:2a02:e0:7474:c000:e0e7:b2f0:b492:96fe])
	(Authenticated sender: tuna@tunakilic.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4hbxCr3Dt6z3xbW;
	Fri,  4 Sep 2026 12:51:04 +0000 (UTC)
From: =?UTF-8?q?Tuna=20K=C4=B1l=C4=B1=C3=A7?= <tuna@tunakilic.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47a1: Allow full-scale output
Message-ID: <20260904125100.185128-1-tuna@tunakilic.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904143848.00000d7d@gmail.com>
References: <20260904122513.175298-1-tuna@tunakilic.com> <20260904143848.00000d7d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Fri,  4 Sep 2026 12:51:04 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=6a9abeb9 a=g35c8EtFT/OoTG0W9QvO+g==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=pGLkceISAAAA:8 a=G1-InoR-YX8NLvKGzpIA:9 a=QEXdDO2ut3YA:10
X-CM-Envelope: MS4xfBZiKsz/ZEozMMYAkeFCdAykZXhOeMNJxxgcE69NVVL94mOtyy93RWX4WdeDAU6OgD5TpIjUv11v0X1pXlHYSRjvXEc1dkXmeLjA6Spi+lBdouelIqIQ 9cKxWpPe82fN0YqZ3dqN6mbISfoC8Yb6BEwd1L5jCkQlt6n7Tyfr954W/TUMtrp4hyclsXUuf4tVEPjNuDiGfssA6MOXatpZKmBPy9kpmg8rUBXISAMk5D2r Q09fMkdm8TH5Dn2dp6ZzQxq7F2KavQoPyxzZVQQN1iiCtIwHVAE/AuRhRp210iDd6hIrjMOvMVktOSPcOtUyCFg76L7rGzoALTPVVx2ge6zLhuODXgcPuGKk c6PjpzhjoqiL4bKHeC5FUPmdOego101v8yjc/9fsKu9W9aiBjQVmtSOZhqpRWT6wcRmwjzKPKss6Zss4e9xuqcdPyb8/Ow==
X-AuthUser: tuna@tunakilic.com

On Fri, Sep 4, 2026 at 2:38 PM Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> Can I ask how this was found? Manual code analysis or AI?

I noticed it while reviewing the driver's range handling and then
compared it with the MCP47A1 datasheet. AI was used as an aid during
the analysis, but I manually verified the datasheet values, in_range()
semantics, and the final patch before sending it.

I don't have MCP47A1 hardware available, so the testing was limited to
build and static checks.

Thanks,
Tuna
