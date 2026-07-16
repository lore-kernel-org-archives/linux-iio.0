Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5D3C343F;
	Thu, 16 Jul 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205986; cv=none; b=afHTHg/cbm3pwsU9ohUeA6uVq1qmWHKv4rn/XmImE9wFhduBoUV8YN5r2SoVDejiTXlA93fxYcgCo3qkKbAPBU/CSnYjpTuO5ttOM6xRxEvHEHFhNQC6JzRAS7xgdVOLW8RntmUCpDt+M8qwqrdWtryY2KafTC+867LC1d7MDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205986; c=relaxed/simple;
	bh=uYcQvj0hwwX1AGcRQYXLj/YYSwq84mINBGd0N25Bqu0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=I+JEzGGvZ5qIQj0KMIqONovH/LPIbs89uydrTf+WsGeQsoiKWF9eQmkL4aw9Y/rsOqLvLra3Hik+1pHveGnQaGxJCBbJJVF1h40qqU9C5TdyzSXiqU+rj6zkCSMIdFTj6jt1rp4MKSCPppc5q4qbPaeWKfFF1UXPoFFDjt/8yEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W1cT/g0X; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W1cT/g0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784205969; x=1784810769; i=markus.elfring@web.de;
	bh=uYcQvj0hwwX1AGcRQYXLj/YYSwq84mINBGd0N25Bqu0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W1cT/g0XI1Hs/v5NZ93hxz2ceBhW4BDjKua6SuCA9e8LXzPJ+ZuSSNiNxn/iARm7
	 XOc0Exj7soSZ5J6gmFCOcyL/FwWAcK5eOzjJha7ZwKJNBRRBU+CMhD7imtY6QB2oQ
	 g8L2PZjNd4lR1Cvm8OyDNLX7NDOEwuxZ2leQX22ys+XR8WPOGCDPC/XhZxc+R2z4C
	 vvvF1ZuvatcUGV7N6C1rOYdh/KTgImvsReuyg/d/HjJVAQfoJ0ip0VMdUQykXjU3s
	 uP+xn9SCT2P6j9eK0+/wE/Hayoue6I6A9BQyF+Y2ZXBRLg4B4MVetdFu7Lqgm4i79
	 /Q/7Xe1NruZmU13UuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1wqPl11tl0-00FydQ; Thu, 16
 Jul 2026 14:46:09 +0200
Message-ID: <c67da28b-ddea-4c09-8f92-abc724bb95f0@web.de>
Date: Thu, 16 Jul 2026 14:46:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux@analog.com,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
References: <20260716123100.100394-1-vo.kratky@seznam.cz>
Subject: Re: [PATCH] iio: resolver: ad2s1200: use dev_err_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260716123100.100394-1-vo.kratky@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iqQo4Y/5DRUqsmDwu7P9h7buB21OCsr0LKfi1N3VFjWZO+oyFWk
 x2WSVf4S1/uAJHujJuwlA/XYTXlCI9LCQ9qtjizh62wsQ6L0vK8p3W4O5pV/baKU+OkP0vp
 NQI5tJg0LbClB08wnqnVXVfI6Xn0cAHebvCKINkfiWcGq2nHw81gUCETbdSjC3wrvTA2GR5
 yzXpBiogjLlkyXMpejCCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qs1Np39HqrI=;thJSBJGt7h4EkoXDzzt3oL0PRyH
 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
 yWqjxvAiJwNtb7QYSd8iNCAdfvVXLv

> Use dev_err_probe() instead of dev_err() to simplify the error path
> and cleanly handle deferred probing.

How do you think about to omit curly brackets accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.2-rc3#n197

Regards,
Markus
