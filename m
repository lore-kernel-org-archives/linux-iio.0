Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEF49AA22
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734071; cv=none; b=Lo56bVx1uUA6rIvb5tJbcRF0hNHgg/7b/zKnqR3fSCvSYWjfEqohbpMlcCWkwCC5OhjieW/vPtTJsKxvOyy3ZOjJHIjZLH70xtjfee0OPQvH1aXcsltrckBDyoeTV41YtrRK9AF6zTEHc7/mckb26tOxxEzmbbrk3p24uD2tC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734071; c=relaxed/simple;
	bh=SEmeR4FLjJT2YPtaPNjUPThsojh0fPVV6bVT6zfE2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WZ3nU96vl67hnD7IFGL3LgcExaEdP9yHYTP3YeIT6hEePqEkIjpTxLbp187BcVIj/TgvYHcDDDWfT0yjC02kBgh0Y6EqFOde8MQOcSUwn4DHALBxmsD6XuOdsI7RReRu4uaRYuO4T088kWxfsb3as3m0n0dZKpfmRXRC2n+FFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=be+BFe5s; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gYNfSGXb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="be+BFe5s";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gYNfSGXb"
DKIM-Signature: a=rsa-sha256; b=be+BFe5sXrf8abcK9x5P7FpVoZdDQOm0PmYtJR5VLWKcV5B7hJ53A/MAvQJqcKmsXACsOzQlYpvM28DRZRNPoCryiqVAnkifLSBVTKRw1qQd1mBiV+E88YcXrxz6bbO7MyugdDjf0GwJgrtwFwsq8rTVQ5DgHySxf8G9GWONmy0ZDFiOEYFiF0bGCuZDIpRhPTKT2nG/J13qnbZzpHpF+B9/+FXsRqoD7Mno8WAA87n2Y/13LvsUFShbW0dwbAP1hZoi0ieTZOGZDtx1rhjmFJC4Tt+fnkM4P4ZBxmGpztHkuH0269+TVOEX5PR9TS27l43QOrSP5dB4RcgtywwKAA==; s=purelymail2; d=arkamondal.net; v=1; bh=SEmeR4FLjJT2YPtaPNjUPThsojh0fPVV6bVT6zfE2vA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gYNfSGXbVuIGacqrUyzX4vG8zDnwXaGIhf4KKHmXCXS0znbMLyX+xTwdbcJvqNNCKE+or/5VO4kW6WIPr/m1DwhmECT0GCJEnJ4f5pNq+mQdwOupBwysiUeR4NnHisR1r4ofkUYlftbTy/+VfVhgiHPDmxgiK5RZls+oR48mWMAhognHHhG8Xz2G/2tzyfo3elcSva2u1USusLX+3yaGCBHB7eByleV7NAFlANQrN3fIbTLGYzhOsStLJ59p1fWxV3iLoEdJ+AZQec/uFEYq6zgZb9gXtmomxRA89QEAMRwnJtk/KtoQJPgHrlfiuQAQIHNNXYszk3rZqIQsoLkZaw==; s=purelymail2; d=purelymail.com; v=1; bh=SEmeR4FLjJT2YPtaPNjUPThsojh0fPVV6bVT6zfE2vA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1407208783;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 12:20:48 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arkamondalofficial@gmail.com,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH 0/5] iio: dac: ad5758: fix DMA alignment, raw range, offset and 4-20 mA
Date: Fri, 18 Sep 2026 21:20:27 +0900
Message-ID: <20260918122032.134947-1-arka@arkamondal.net>
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

The first attempt to send this series on 2026-09-18 was rejected by
the kernel.org mail servers, so it did not reach the lists. The patches
are unchanged.

This series fixes four bugs in the AD5758 driver, all present since
commit 28d1a7ac2a0d ("iio: dac: Add AD5758 support"). The last bug
takes two patches, one for the binding and one for the driver.

Patch 1 marks the SPI receive buffer __aligned(IIO_DMA_MINALIGN), so
it no longer shares a cacheline with other driver state. The 2022
conversion of IIO drivers to IIO_DMA_MINALIGN only changed existing
____cacheline_aligned markings, and this driver had none.

Patch 2 rejects raw values outside 0 to U16_MAX. Writing -1 currently
gives full-scale output.

Patch 3 fixes the offset for every range that does not start at 0.
The +-20 mA range reports -32 instead of -32768.

Patches 4 and 5 fix the 4 mA to 20 mA range. The binding and the
driver give it as <4 24000>, which is 4 uA to 24 mA. The data sheet
(Rev. B, Table 32) and the original text binding say range code 1010
is 4 mA to 20 mA. The old value is still accepted: the binding marks
it deprecated and the driver maps it to the corrected range, so
existing device trees keep working.

Compile tested only; no relevant hardware available. The binding was
checked with make dt_binding_check and with test device trees:
<4000 20000> and <4 24000> are accepted; <4 20000> is rejected.

Arka Mondal (5):
  iio: dac: ad5758: Fix alignment for DMA safety
  iio: dac: ad5758: Reject out-of-range raw values
  iio: dac: ad5758: Fix the offset calculation
  dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA current range
  iio: dac: ad5758: Fix the 4 mA to 20 mA current range

 .../bindings/iio/dac/adi,ad5758.yaml           |  4 ++++
 drivers/iio/dac/ad5758.c                       | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)


base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
--=20
2.55.0

