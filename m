Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E12343BE
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900964; cv=none; b=QtK63fCgEfB1YNELupT7vGSFC49wVBDktqht42G65klZ/08cEObIcOQXcRGbkCZLkzx8hMXaVcmzGQbDadZ7jQWLJ/w1arGGqRmX8TJZFGlStryU/ObtQPSq35XS1pHMpI6Yr6hQAQfzDYGFjK7YpJWYrMpg8BPihzL+vMUhk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900964; c=relaxed/simple;
	bh=M3FwgjdrARsUzI11t5oCZFhdT1YhCHWrdHWf0wxR8Zw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GoibpDMC6lHLTkWmHKto+wGEjiVvKJaZw3cFftKVRst+QnUyvOiR54+wGMl0X6vrWrZ2K1u/zCFb3BAOJt2jxQ3spfnFkkshb8nw8QttPKAQiPWqEsCnvfW4UmRJJ7ws1qrLvq/UoFqClQq7hGcyz3YVPYSE+53ljQptsjg+U/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzGtmGl/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzGtmGl/"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7982c3b7da9so26843027b3.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900963; x=1772505763; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3FwgjdrARsUzI11t5oCZFhdT1YhCHWrdHWf0wxR8Zw=;
        b=PzGtmGl/6LTPm7DF+tRlMZyozuJYs3ZbhBXpABjjWOZ/e4H0yCSooX5qlQWL8fdUWV
         6GXu86fUotJSeBOeOC3XShSHtR0hQqamGez6W8xwSYsW0WdJDQ2Lg3gtm+TbxWP9VH74
         EOKoJgrmT6PGh54yeevtTlWnBx0Cnl9Idx/M091fU+hjOm4PDKI8UslNhUwwRqXgCvUg
         Z/pR2HWsly4LFHvKIOqUfEsKrQLTj0dOOiryoJ1o9k0ZVCPgTIde4gBiDdXDKBMl9gwq
         Ey9p+8D14DbeQ1c67APdmZ1PM9ePP//i6uI7hFqO70Jic0zaUc+CiQX6DzegpgimyAO+
         aGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900963; x=1772505763;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3FwgjdrARsUzI11t5oCZFhdT1YhCHWrdHWf0wxR8Zw=;
        b=PXADA76sPrr/OTM9Wx4f4jv2Ykf5Ij8a8THsyN2G/iH9HN57Voig98meZT+ITIONHm
         yH+ujGr/BnS3+21gw5vgT9ix5ixC/tfcf6Juk/t4abbjnFXWmwf4zIh1JFuhOSlmZUY/
         4Mer2W50UBCui1kPajjZqut5lczpSLhR3aXTGqxxWUu1HHUuncIjHePQf7CXMZKWlfm2
         AYX3xIqPHQSqv06haJ9ZPLIhnzmTDFE3jqBVoQN7+7y66m09J3F//bfvbbaMAW44ISM/
         +MwTSXfA0r2Su+1amUnyToFQFOfGWC0oljN2iPhiXX9HipGXC1qVsLIN8Fn1VEV2zPNC
         92+A==
X-Forwarded-Encrypted: i=1; AJvYcCVwR0ucZqSFgJ/oAXKmtAql5RUI5iMvrVfc5e3ap/d1SuOsMBVhgxM/+QIlkcVgrjMPSHVvW/ilxYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsjk0NLHn+DWvxxgsFmqOlv8X19JOAxp0ap3c3GUoRVQ0GNe04
	+i/tNZSD54nqoRkB86xPZygcarKBjBCwdg9yP19bly6J/9EgJWmoS6eN
X-Gm-Gg: ATEYQzy4ec2ZoXVmkyYpqgtpZB+BSx6JNFBl6i24AduH/9fR0VNlO53poMNm1/JFoBP
	j1qtTYRoXFNrPPjyhzgd9thP1VTyuVwiRrYtN0f9hFD+JKCWCH4bdDuBtis6KTK3qYi2OFW8byy
	L+lUyRx3BYWQuPQMi9ch8hyQyZLUQRHYV2DLXcaTlWC77F01FATb/1TnleH2mmxnSsps90g8lnR
	YQ9BCb5xV4cD/CwEpqVEJ7oioJjZZ/MAd6cfOeugirK18c6XZxk46HntKpK+knt7m/kxEjB3Za8
	HRL6jfBTYwLi3jZV9gNsnNKK/7spjs8H0eDfI7bNYkyMzZQQI0zPCLmNpcE9yBGXPr4+4ZbzuXs
	Dm+H6ja1WFNzfwgUlvTf8D7ERDAk9gWkIH1j8shGV1TWSTX3gEOh3MEWtuKnUKj2MOdRW3h6zpP
	CjTUVxIpHM62msEcMTeHxSuOvZ7maj+FBKE7bJ3BTlcFPOQWL7maS7bZ34xpyc/hlVf0pAxePTK
	nQZGSw4w6Y5f7HxiZNjxHrDVNiVcege
X-Received: by 2002:a05:690c:368d:b0:795:294c:fd3d with SMTP id 00721157ae682-79829032b68mr92666887b3.50.1771900962870;
        Mon, 23 Feb 2026 18:42:42 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddc6b65sm40068197b3.39.2026.02.23.18.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 18:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 20:42:23 -0600
Message-Id: <DGMUGO8B7SZ5.15TPOD74KU0Q3@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Linus Walleij"
 <linusw@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Multiple bug fixes
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
In-Reply-To: <20260224023511.274038-1-ethantidmore06@gmail.com>

On Mon Feb 23, 2026 at 8:35 PM CST, Ethan Tidmore wrote:

Just realized I didn't put a changelog, the only actual changes is the
implementation of devm_ to manual cleanup with Patch 2 [1]. The rest are
new patches.

[1] https://lore.kernel.org/all/20260220200522.19967-1-ethantidmore06@gmail=
.com/

Thanks,

ET
