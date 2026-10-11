Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75D31B80E
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791743026; cv=none; b=PT+NCqkBxQiKOfq4Ohfv8QML6kL0NntJXhpJBL+XdN4nXOIm2iyJ9tSO0ix0Vr3pxwPry1Hp6iMHd5Xm3A05D5aR2lcLkL2teMwINYcwB3IdiipOecSQz1i3s6kIzXSL10ueQsnK0vyVliWTWfOCC7eyRD+ZPk7bDhVpmHRf1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791743026; c=relaxed/simple;
	bh=A7BLv7zQPHQbA7Cl8xvO0zG9ccyDlJYY295+nQ2joAM=;
	h=Message-ID:From:Subject:In-Reply-To:References:To:Cc:Content-Type:
	 MIME-Version; b=Youvo7fWVfEcG4psbvDQtlKhJc4wvHM2voroqFblrCIqPuTzDyZeNetAEgcXGp5Mh66xTZbTQjsfyZUDzlxc7M7eedwDZGVYkoc/FtMc2B2q1t14OTM4X+OM2x/DEdNvy5FeTg9xFSVhPlBK8yxzz9dvFigbELNVnA6kiAu4U+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Hj7jTvxw; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Hj7jTvxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1791743013;
	bh=VdsR6S5kk88TQajpDBja0gowAf8AeMrbKQKRf+EETLU=;
	h=From:Subject:In-Reply-To:References:To:Cc;
	b=Hj7jTvxw2M1t3l3PTx1OZcqIvAFwNy3IBo6Gp5/siuLZr5Mv4+M1zVb78RBeXMgkT
	 7BQw/kavKNFBuQKRUidCzmG8zJZtL843Oj4P2y1n6CP7lIicyrZA+VcbNR4WQaLos4
	 46m15EoD0zE3gN0CFMgSfKEi4IyDwyiqvr/ToWto=
Received: from [127.0.0.1] ([112.224.162.161])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 5DEAC067; Mon, 12 Oct 2026 02:23:30 +0800
X-QQ-mid: xmsmtpt1791743010trznksxcv
Message-ID: <tencent_49212C8C3888A5E45A84D7F1100451478D0A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5TXLMterhEs4bUuOPZX97nKyWzeqqvc7f2Atc+W7ft5mHLiNU/9
	 npUeoT+6e5YlpQTUJLUmmJAh7JU1dMHTuyD6xQTPP1IfwyzPQXBrtgdj+vI8p9m5ZtrRgvanMG82
	 OjqvNl/JJx/Ux0S22wypmRF+NZzjjWThDiYpWTeQBE0+mSKTFjOpA0Ik0NvXEDeFSHzjJe3IMPWM
	 V+T6Vs3iSBShu1aAA+UT5V8BDcW1a2Cg8Yo+BrhcXqEpi7RWROvhwoTngMwWli5HH4j5N8B1Kuoq
	 Czd4D4N3/waJ3Y09W7A/GQTdq1HARYcWNYw40ofD1qkKn448/qd+LrYUX1JSvrybJYoa1SEOWGLS
	 3HfCTHezhvFnq9CMb7FDQ6uxTxmT9r+8vlK8dDRpba0bo6iIjFX0DUwZ+ewHO7+9qNVH9jFUTpx6
	 mPr47oAXQnlN21zaGjWh+hrbyRhgDUf3rJgHBLPTsufxXv8O2TSu+z1VwDY/yMr+BVt6HZ5wY9iG
	 qQGU0zx+0oXA44mLhREy6cbHubAibHOf9frckW6mYSzi0e25H4+SKT4OOV86HibgwE0LlCnhKlzO
	 oe3jn3295JukADEH2tJ45Ue9lnD3hySsrBkiHCfSapcHRpEdhS7Vm/SKcHapdKYengVcoFQAY/pf
	 Hi61VJBN3xOjFHFqpTqFfJT2CBwF17uN7ErCs6OJ43V64KD4JSugyAldK+ouQ1vN/g8IvDkT5lM0
	 Ciq3Bs+BYH1+VNBoXRjbqQXVJxDArTJt+4/FWR9a60+YER6zNTBJb2rQn5qnx12NYZijEteMNNc3
	 gTq4NFcvROCDpUvMtUc/bciYitpIclfBiXs+4X+etwhPyyb4khjTiLk0miNW4JobZFq+VzG+OWSk
	 CFelW2G7C01uBFkdCvw+SPhea4uFruV8AptwZC2fIcSpxdTthp+nbQin636/03Dbm28fe+m4UQqK
	 RXedd8vPqMX6zLyAG+eUKUyRQyZS57rCv63XUKsFVMgLXpTPqc8vbuyONg8dJ+cBTWR9eOPhmt6g
	 auD9m/L3xZ3ppH+vDPTen6AO3kiBbxJpH3Ji60REgcTrYjnCYmrxmzm2/6PwFX1jfG5XBDUo1ac2
	 B52IR0neh5pvGXhgufi52/dQLF1A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zixin Wang <ywp1023456@foxmail.com>
Subject: Re: [PATCH v2] iio: light: cm32181: add support for the CM32183
In-Reply-To: <20261011193116.4e7a4336@systembl0wer>
References: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
 <20261011193116.4e7a4336@systembl0wer>
To: joshua.crofts1@gmail.com
Cc: ktsai@capellamicro.com, jic23@kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 11 Oct 2026 19:31:16 +0200, Joshua Crofts wrote:
> Also, could you add a Datasheet: tag with the CM32183 datasheet for
> documentation into the tag block?

Thanks for the review. I can add the tag, but I haven't been able to
find a publicly accessible copy of the CM32183 datasheet. Here's what
I checked:

- The CM32183 product page is publicly accessible [1], but downloading
  the datasheet requires a My Capella account, and that host's
  certificate has expired, so the page is http only.
- "http://www.capellamicro.com.tw/download/CM32183.pdf" returns 404.
  "CM32181.pdf" is available at the same path, so the URL pattern
  seems plausible.
- The public CM32181 datasheet (Rev. 1.2, 14 August 2013) does not
  reference the CM32183, so it doesn't document the part this patch
  adds.

Since access to the datasheet requires registration, I'm unsure whether
linking to it would be useful to readers. Unless I've missed a public
copy, would you prefer that I use the vendor's product page as the
"Datasheet:" URL, or omit the tag and add a "Link:" to this discussion
instead?

Apologies for sending v2 too soon. I'll wait at least 24 hours before
sending v3.

[1] http://www.capellamicro.com.tw/EN/product_c.php?id=96&mode=14

