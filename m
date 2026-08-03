Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAC259498;
	Mon,  3 Aug 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762102; cv=none; b=cx0JDrDO6t1nLzGcu8d8/TdolapGFNx+por7qVZmKB/KY3nmNojb3iQlIr2EBleKxYSq+A70FE4B4YvRK/mShivgpiZge5dnyaxEymPLU6gKm/4bsBbIE6cgjBPZFRhZN1gMLIwL0uowSP+8LNA/dPkNDNm2B5oFjXPCWN2hivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762102; c=relaxed/simple;
	bh=ezJISrEoePE1EY8DB9b8YNAe9MBaTHICcLllCe9vJHw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WWBeXXWmGAZYOmFG7noHdJx8bFlZb97FqInF9GtzEunD8vROrb/Z0jWLlmzwgTikKk/dC0TxyV/BcObKPkW6jqVtHJXyoN0HcIEW0vZBW6MEJIaLNq8HlbsSFnkn8Dln/IOOQ4EGzx6xW2OE+Tl1Rx0gb+MvkyqQAN+8MjcNOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VGpkFSKa; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VGpkFSKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785762081; x=1786366881; i=markus.elfring@web.de;
	bh=ezJISrEoePE1EY8DB9b8YNAe9MBaTHICcLllCe9vJHw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VGpkFSKaaoz8gxe36/wMozKWNcCyXFyc+I0AfaEoaOQm1ofu2GFRKqU9T+p/Fa3l
	 lKPSCyy1oNPumryR9GAwWtx9KpY8RZBG35nwr4sUeCv5HZpInOe0AfBxDI0lafaDY
	 iMFjpwjbpJ67xAw4F5fcsFxDj+NAqGY/WPV0ybr9nfPK0sysewJce8LbGxmAYD6Wp
	 lQ9ojcpM4/90jcOs3/q2YC+2tg6SnXCydaFRD7ln6zjLYTuFBX0Y4ANQQhbA5ezTZ
	 pGD4ECor4OzLnW4HkXQ6qgsiK08fEcJDbFX6USlJMe6A819TKLJ61IuCGFq5TJshM
	 GuS5bA3S2o3uCnVUiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1x7Iku3uns-00y9n3; Mon, 03
 Aug 2026 15:01:20 +0200
Message-ID: <a366c5ac-d527-461c-bedb-030079acfbf1@web.de>
Date: Mon, 3 Aug 2026 15:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mohammad Shahid <mdshahid03@gmail.com>, linux-iio@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
References: <20260801090953.61603-4-mdshahid03@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260801090953.61603-4-mdshahid03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GgUYJWlOQB3ymFt6m5wYLyI2s5natgRmol8bqeNSPhIQFVVGpoz
 nEui5kh8s9cfj0elW7RbOlrDamZl4jRQNH52ESqiOn0kLSwiTIY4phxK3+YJqywqhJuoHzK
 +QD8bAEi3suxZdz8UvpqQs4ziINK0lRnVGBFS8n8W4D6A+qhYFwHQZL3MjJKbzulrWSVpj/
 nqV8ijDGo8DOSHtlsNPNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:32AJEx46HGc=;L1PWAEfJAXFzqg0t7VzL0nGmV2B
 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
 2r4ozY7hCn+OJsXg==

> This simplifies the probe error handling by replacing open-coded
> dev_err() and return sequences while preserving the existing
> messages.

See also once more:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2-rc6#n94

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2-rc6#n669


Regards,
Markus
