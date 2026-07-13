Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8E3932D5
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981868; cv=none; b=mgyMUqimzJ/IPMNwPSZFxAVb/G24nmFiFwCvihf/5O8E5KcJv/FbkYYSjVTphIb3/AvJrOGKpDCy3G6oFLrfZ6PyeS59+NIIXIi5bZU87o47QwYiDBhHZweCPLRsHpPX/FMCoo/RFEYvHNhl2T38m7vN7PzyykcJHFvdmi+8A1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981868; c=relaxed/simple;
	bh=sWjmpWjFUSdtN3IsSpg3D8O8PRwIarAUAfovl6KiEyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B60j9PeoXnLBg2kHTPYSPa86wQHRxKgbrykPtXu0kqo3fuwAujbSNfR8EXNmPAoAwFCzcWUJjhN7sRjJMIXomZEGMWIReFDmbBpcXjQVnm9PU+kSoGsI6r9RFtIe1sBaDb3KFsjsydY8Ghon1SWxQxjMJ34HCogTZIPiunqvE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=g7piNw/K; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KXQ5IQYj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="g7piNw/K";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KXQ5IQYj"
DKIM-Signature: a=rsa-sha256; b=g7piNw/K71oo9oX/aVYeGLQDD6/OzKQSPZnjGZcuf0xxUOcIAin/duID9lFq9nszgmKq9rmUjCcY7DM+0mm2h+wgGiplvcADedChZwLR7pQijAWN7VaHu1uAxyMTIaS0zd4KlxRFIClNcukITUiItiDzuy7Fp5QBmf+wpKxNT9k+m0htvTd2cUTCO30iIJ8jYinZceo6oWA+as0TEqoYKeUvAWdtf2wmnnhH0TReQ1SILKQxNCnR9U+obnhCAen63b4CnQa+GN4Omuwf/Wyy5R4EU0X8LpPUDkCl8ks7PGse/EpKI0pD+yJrgxAa3J9R/jUPYHmX9hJlcRGLrgBN9Q==; s=purelymail1; d=maxwelld.cc; v=1; bh=sWjmpWjFUSdtN3IsSpg3D8O8PRwIarAUAfovl6KiEyk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KXQ5IQYjGggeYFv+6+HkE38l/MUMNJBzvxpyc3k708F007jm6h9iMCpF7+NDrwF3fIgM8mgzRHRFQSSBmokDR0klGwaSaXHQ88DGzJbxadPQF7L4WyrkiAH9+MKsuRMo7HNAzy1VmmTYmQd77Q5GXcDwSYTgrBCRPvkoSqld3sDsQ3nbiaIVYxkBQPDQ54DRAgWhJ/wg2M4TAyWa+nYPhrpWVsoGPPWD3BLZjYcgAoRv1Kjh1nExFj6TVMbUiBV1k1H/HJ9iVakJkTzVZWBgbGxb7oe9xKT3SYg2GDBVhH1CiRuGqGdihbjIHuPKLV0qD4l0005Tts3o8D3EGd/xgw==; s=purelymail1; d=purelymail.com; v=1; bh=sWjmpWjFUSdtN3IsSpg3D8O8PRwIarAUAfovl6KiEyk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -21516782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 22:30:47 +0000 (UTC)
From: Maxwell Doose <maxwell@maxwelld.cc>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?=27Nuno=20S=C3=A1=27?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/3] update email entries for Maxwell Doose
Date: Mon, 13 Jul 2026 17:30:43 -0500
Message-ID: <20260713223046.20779-1-maxwell@maxwelld.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This patch series just updates my email entries around the kernel to
make sure messages still show up.

Maxwell Doose (3):
  mailmap: add email mapping
  MAINTAINERS: update email for Maxwell Doose
  dt-bindings: iio: chemical: sensirion,scd30: update email entry

 .mailmap                                                        | 1 +
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--=20
2.55.0

