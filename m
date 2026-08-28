Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495F3AB26A;
	Fri, 28 Aug 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909598; cv=none; b=ojN4Aeq86Hb/C/yrgIUqqCE5ZU5LcGIWTFmNUfn2+Uq1rR3m2Bj1Twuv+HKVD+/Fy5zRMQXvzVq61OEGZYqLtAPVAc2AsPyZNOHbhTGNjCnNuLUt6pNwZ9koqxAOUftLlvZqAcRU/3ywc/f+BIIvibNT8h3vQ19npkKZgMiaHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909598; c=relaxed/simple;
	bh=ZIr2Om7HJVvvAwPSuCzQVLpbjbzCkAHbgG06l0WUFi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=C0ZMNfp9WaC4x3m1O3RLEnrJrkEtDsIdQaC1FRJVnCg8HC+RYnElAEhXO05pRhiWX/J+7gNQr2xXEfgatcK+jrQl7LnIkfpyGoz/wOglGgXxA+gNMPO6DIyEumuZHCM/IIUicLPVf+onvfHqXGlZNGWRQaaHb3d3ofeunSGKbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LekAQvzP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LekAQvzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ZIr2Om7HJVvvAwPSuCzQVLpbjbzCkAHbgG06l0WUFi4=; b=L
	ekAQvzPXK6LprzbHFOlq1dRywsiDpEWm0BPjygGx99GYKQOFU8+fbagHHtvGazkk
	VYiSK4ZxyY8BcF9j7uYD6d0fyIvVQsJW91oiytQc61oVxXtaJfhG1WvnWlRbzaxz
	3Fjl9i1ogPLkrDlNUK5NRk6K5a7o0mT86qgFewsXjY=
Received: from dayou5941$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-130 (Coremail) ; Fri, 28 Aug 2026 17:32:46 +0800
 (CST)
Date: Fri, 28 Aug 2026 17:32:46 +0800 (CST)
From: =?GBK?B?wO7T07roIA==?= <dayou5941@163.com>
To: "Vidhu Sarwal" <vidhu.linux@gmail.com>
Cc: biju.das.jz@bp.renesas.com, wbg@kernel.org, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	"Li Youhong" <liyouhong@kylinos.cn>
Subject: Re:Re: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable()
 return value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAFqz8L+TjFmnKpJtChJA6c3O0TJv_O=A9Lb5bdzbVQTeFHg8BA@mail.gmail.com>
References: <20260828071123.179670-1-dayou5941@163.com>
 <CAFqz8L+TjFmnKpJtChJA6c3O0TJv_O=A9Lb5bdzbVQTeFHg8BA@mail.gmail.com>
X-NTES-SC: AL_Qu2TBfWbtk0t4CmfYukckk4Wjug8Wcexufwj34NTc8EFpinq+jErTER6EHzs186+LQq9mj6bTCRhw8FrWKZAvA6LFiMGZm71vtG80idAwQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4455217d.77da.1a047b6f209.Coremail.dayou5941@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gigvCgD3t+y_VZFqIOM6AA--.124W
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+h+DMmqRVb-wBQAA3w
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA4LTI4IDE3OjI0OjU0LCAiVmlkaHUgU2Fyd2FsIiA8
dmlkaHUubGludXhAZ21haWwuY29tPiB3cm90ZToKPk9uIEZyaSwgQXVnIDI4LCAyMDI2IGF0IDEy
OjQ2IFBNIExpIFlvdWhvbmcgPGRheW91NTk0MUAxNjMuY29tPiB3cm90ZToKPj4KPj4gRnJvbTog
TGkgWW91aG9uZyA8bGl5b3Vob25nQGt5bGlub3MuY24+Cj4+Cj4+IFRoZSBkcml2ZXIgaWdub3Jl
ZCBjbGtfcHJlcGFyZV9lbmFibGUoKSBmYWlsdXJlcyBkdXJpbmcgcHJvYmUgYW5kCj4+IHJ1bnRp
bWUgcmVzdW1lLiAgUHJvcGFnYXRlIHRoZSBlcnJvciBzbyBwcm9iZSBkb2VzIG5vdCBjb250aW51
ZSB3aXRoCj4+IHRoZSBjbG9jayBkaXNhYmxlZCBhbmQgcmVzdW1lIGRvZXMgbm90IHJlcG9ydCBz
dWNjZXNzIGZhbHNlbHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExpIFlvdWhvbmcgPGxpeW91aG9u
Z0BreWxpbm9zLmNuPgo+PiAtLS0KPgo+VGhpcyBpcyBhIGJ1ZyBmaXgsIHNvIEkgdGhpbmsgaXQg
c2hvdWxkIGNhcnJ5IGEgRml4ZXM6IHRhZy4gQm90aCBjYWxsCj5zaXRlcyBsb29rIGxpa2UgdGhl
eSBkYXRlIGJhY2sgdG8gdGhlIG9yaWdpbmFsIGRyaXZlci4KPgo+VGhhbmtzLAoKPlZpZGh1CgoK
VGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJJ2xsIGFkZCBhIEZpeGVzOiB0YWcgYW5kIHNlbmQgYSB2
Mi4KClRoYW5rc6OsCkxpIFlvdWhvbmc=
