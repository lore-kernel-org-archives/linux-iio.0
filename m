Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C128150F;
	Sat,  2 May 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777726441; cv=none; b=Qe/sbHODe6rrQq5PH5H8peHph2+iao+lxu2TiGmaa1uSoels08IdfoW0eMR+l07R2C1TRLKj13BMyLfJUzBEFT1/ZZGNFAhwAPZ1DTKp/4DT7TvoPTInrplomRsthFYXPxZt9n3CPbwcyEGIr2Y0jctbFTvLb/vOFXNAWjP7hZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777726441; c=relaxed/simple;
	bh=JlGYREQ3o30oAsvMBPCEdBgpvU91I7Me5WIQkVmDniw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aUxaQ2qRnkfeY3cr32KFhhVN/JMyUrvdLRP9O9QtM482Nb507TRS0bO0sx/o/sNSd8whI+fE66DjEAlC4W89fsY2JtNUpofGpt4Ns5dS3Y2dDtrcspZ8n2dX3trnqa7uqrI9VRWa1gf1qN/Yv850InvhPXeeu92v0SUz5h31Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pSDPHpI/; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pSDPHpI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777726430; bh=JlGYREQ3o30oAsvMBPCEdBgpvU91I7Me5WIQkVmDniw=;
	h=From:To:Cc:Subject:Date;
	b=pSDPHpI/FyNe/7QPmM1SnpO9Ltnu8jHZTUg/YwPfzj1eLhsvYpCOrHKyiGRX5Kk7O
	 kFXbCNgkaVwCCdbCjq09hfZGmm+w3efsaEFqs/buOEjhU7G3skobuEdaG0ZihPrHvw
	 xrwF6K7BpX4Mb9WqkNrsaeoS43RNXiWwM6Ctv3mY=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id D6F16215; Sat, 02 May 2026 20:53:47 +0800
X-QQ-mid: xmsmtpt1777726427tjpnj8raq
Message-ID: <tencent_5E6677A3FFCB969503EE5250592E75128807@qq.com>
X-QQ-XMAILINFO: ONXjbYTFhCz0yW82GnrNThR/ZKHFLt7q2Ck6IYs1QOjSWMcxpTVzuAPVOWQZMN
	 XUQ/hAxHxvpyHsKwaM7f3aEnURUY/Hh3AqwPsMf4jEUzHaQHBAgrnj/sIGd+oikwHCNjHkDxi1j9
	 j+p51ostKBmm8pDlhIXPUNBR4KKEbJtYKfyvvSUoD3RMgVY5SFLkZdJiZmJmlEx5nsLecW1wdRn4
	 n48gCAc29/I+olVJo53NLv5Kg/fpGEbyFGfjOqxqTGCml4juh/MLIuJF2A9e81KYvX6Z/JmVkBmN
	 MSmwTYFjCNb/x8JtDrelXwVDdIzoOhhx2mSFDXuiyDHcBfI5jokZCs+DW6nbzUWvZ+VWBNYKAoD9
	 Petpeci0+/f0FrgYmV3UbYxjVkDg5N7a01KZSZ5QcUvpv4TnWQC4KA+02prhQamivwcysIEvIJ71
	 BVt5cFV+K9VTtM6ZHiSzECqasxvfz8s/OGAu5fSbZianU5tWxvZalrcqo6b1rxL/KP8AvAToVK6q
	 vRwrL3a+icmUWOHw/UsH/ZfTVi6RYzTDr/dzhsJqznIg0OoWLhG8E3apZHM2SZn/rN3lHOLzE1T5
	 RqVZZn+W6CvfGpjIKYc/xOZWNRS72HLul6eIxJqyRRqNp/5ZY7cYlotR4E4DzqBcXU1GknUO6sqX
	 Gbb8QYHO0aJ7Xw/IRCL6kK8mjaS3RcWTZPliW5WTcDcXsSdPxLM8cgqdjJRCx3w/ciXMGTN4LgEc
	 IyL242M+XgJOGs/K+DdUUqPn33/cyHNPolZdWgcoFtzptpegAIyh0u9JxTphYnBfv61USCcyqz78
	 5Mt0kJwSQpgVddF0hAd6E2u48BEhcnk4JlvBLrOOM0G7WKoznNBoZfOy8G9chDkOp2pXi8uWmVBE
	 yyRtX9msPEytfFa/lorBG5y0EMjLX+xcYiPViNk+wl4CTo3zEMuHbPPpm/Vzjc3GpC4cesCzq2Xu
	 SvFx/ych/G9Xs/vP0QiWjnDly/qRLuxtrt4OOmcwuuwEYVQgjcgM13wzTbwGJMsva73CsRujVV6i
	 1Fl2qZ1rTgoHxQ61GoBxHAHYOE7rXklShJRrDBkw8u7pVUI0Y36x76HvoRpyM84xRtu4p2nl4RaM
	 HaBbmZt0c5TJNN7+Mlrje352BA7BS5eMJtRGkoweWILq1oZE60rTCLwwFYZg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Wang Zihan <jiyu03@qq.com>
To: joshua.crofts1@gmail.com
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: Re: [PATCH v2] iio: adxl313: fix typos in documentation
Date: Sat,  2 May 2026 20:53:43 +0800
X-OQ-MSGID: <20260502125343.495997-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

Thank you for the review!

I apologize for the quick v2. The v1 had an incorrect subject format
([PATCH 1/4] instead of [PATCH]) which could cause confusion. I sent
v2 to correct this formatting issue.

I will keep the 24-hour rule in mind for future submissions.

Best regards,
Wang Zihan

