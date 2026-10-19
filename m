Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFE49A3AB;
	Mon, 19 Oct 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.18.210.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400351; cv=none; b=fiyQD1BNshrBTF8P7Uhe3a0+6lnhDOBvArkLtN/ZTQyAqqgC4Ka3JWwzsyauADu0SbpMRpEsXDEi1DHKC3rAYJgTPPAsuKOPObAuHlGFi6jfWQ3SnuRrI8yu8V+CElJ0DXZS9smDptRbcF72t6DXiMziCZAK/LyH/CsctnGnlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400351; c=relaxed/simple;
	bh=f+80lnP4b0mPEaTT/y2g2gU8UpfSkMla0bea1z22I5w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID; b=BSabGGWjVNeitqgNedU1RBHNACyuW9nMOWQeDE6Qo5l7Masam86Lf22S02pUqtEJ5Zv4ul9wG2ATyRa00FsnSZplGGmNoT8o2W1j1+gs8j3SgOfImJjLlUHuQ2vmqKOwul+18O04WrvC53GuLHpVJ1BTv5fWXYwCdLkwMMQhX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr; spf=pass smtp.mailfrom=noirlang.tr; dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b=ZhSm4tGk; arc=none smtp.client-ip=217.18.210.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b="ZhSm4tGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
	t=1792400347; bh=f+80lnP4b0mPEaTT/y2g2gU8UpfSkMla0bea1z22I5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZhSm4tGk8ZjmUvO98+sv9wvHQS/UqwN50/HfLONyNyxf1NqSAtnjK/vqOrx/D/Dzk
	 nZwjUMLX0Mx9dtUabwsk5j0s5Y63uwcYtQ+jIbH/sybO8UPtBMKjUxeJY/8Vdy/kvB
	 51C3V8JVbPPtZGMGxmSzMkvVmf1XR71k6dZfcAWACO/3utaAOpX0xh+UuQ84tZxSKI
	 APB/EmgXRjjLfvvxh/pGV8e5D/YFBIX03gUi6M3K4DLRKHLly/jLWhy7gbYxDozqyl
	 ymIesSc3hnu0+OTW+7tQmxsyXaychMGoEtZrLDh3yWhtCK17p08ay++VEj0bJV360M
	 coMZk5vDDCghw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Melih Emik <melihemik@noirlang.tr>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nuno Sa <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
In-Reply-To: <20261018175558.71739ebc@systembl0wer>
References: <20261018102604.73380-1-melihemik@noirlang.tr> <20261018175558.71739ebc@systembl0wer>
Date: Mon, 19 Oct 2026 11:59:01 +0300
Message-ID: <179240034171.6365.14876819635016240793@noirlang.tr>

SGkgSm9zaHVhLAoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIHNlbnQgYSB2MiBlYXJsaWVyIHdp
dGggdGhlIHRlc3Qgbm90ZXMgcGxhY2VkIGJlbG93CnRoZSAiLS0tIiBsaW5lLgoKQmVzdCByZWdh
cmRzLApNZWxpaAo=
