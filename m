Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05946D573
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300782; cv=none; b=OOsENnVIzBnQj/EC2f3BXo4YvQmLqzHxhHg3zDQ0VQdD/h1fn3PUI+dj8o0Nl/nG4F0596WyjRHDela6MRKmFI+8B9NGDu+oTbWGYICQVx4ey3WV0W1TVc320GB9E9nX8fVKfj3fVH+r1DlYc/Ex1MmvtvBLtqkkwhlJZVqDbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300782; c=relaxed/simple;
	bh=If3NKSkZQb2DYZa/Ru/MquhE7Axwtfn7wQMCZk/YH8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5cKR5eTRuD5HdLfNFRPtxbQ2jvtMm+jF5XAfpWHTtq4tjaeS1d4xFoXLiSa2ZoLVi3CimT/sp8PKP6hczIKhiUPE37wGTpfczucKTNmKJFBnuNkEQK1Ol6ODYbwhq1Ex4OgpNUqJt3iDyKRPDF4i7/0RIvvOdPr4jiSlD1wPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=JflvQ7+L; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QDHjmWaK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="JflvQ7+L";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QDHjmWaK"
DKIM-Signature: a=rsa-sha256; b=JflvQ7+Lw9eG50giM7gPWiSDD9U7IX/qczp6oF/NVyW/VVs0X+eWpYAhF7FsZxHl200oh3iOnC1Vi0mGt68O2A8pkKotlazV7coH9qO/t5oG1GjZL64AVMVo6Zm9MYzJJsSwji5EI36oeEuGi0jl2WTleYKokR93vkewel/O6jZhfmhrN+saE3avW9Vgh5O8zMBDvUlGfHJ6lGfBdJqX6j/S1lHWG+UtM1XZHxu7ko9xjnIeYlMOfSaisxe93DmYjCeGGCXxmrF4BnvK3rsJWA/z4EnAJWUg2s3QJg47AqC+sFPgu1NnNap1lLv/buFVtSktkohayV09Zj42Y5MZsA==; s=purelymail1; d=arkamondal.net; v=1; bh=If3NKSkZQb2DYZa/Ru/MquhE7Axwtfn7wQMCZk/YH8A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=QDHjmWaKn/FOdYivrdWX9QEPd/T3l/rjB6FeMUk9E2Jv2yWX+10/ABoLa27HEbLJAMEVk/Ju95+/HQFEra5h+PasUOugDOehF7SPAD28QaQu5S3hXvGSrlififTXGsbqK07nCD2PD7Wn/DP+MdqEJHHIK7/x5tkU2YM3mT6UV1CCOQtvqwJlxXX9DOh8X8IpA90z88g/hpNtRIZ0Prfki8PR5mFmv/sVn1e0Lao+5sz4DCaaqgJP4cSGGb+CfBQtN+srDXbA0rWqIBAE5zg1nkX98px3EUjvRE9v0kHPLhr3now93Jn6Q8ey0OtrshyujdivSePsT63wYbfR/gtGtQ==; s=purelymail1; d=purelymail.com; v=1; bh=If3NKSkZQb2DYZa/Ru/MquhE7Axwtfn7wQMCZk/YH8A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 491803982;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Oct 2026 15:32:29 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	arkamondalofficial@gmail.com,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 0/5] iio: dac: ad5758: fix the 4 mA to 20 mA current range
Date: Wed,  7 Oct 2026 00:32:08 +0900
Message-ID: <20261006153210.364862-1-arka@arkamondal.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

These are patches 4 and 5 of the v1 series, with the deprecated
<4 24000> value dropped as Rob Herring <robh@kernel.org> and
Jonathan Cameron <jic23@kernel.org> asked. Patches 1 to 3 are already
applied on togreg and are not resent.

The binding and the driver give the 4 mA to 20 mA range as <4 24000>,
which is 4 uA to 24 mA. The data sheet (Rev. B, Table 32) and the
original text binding say range code 1010 is 4 mA to 20 mA.

Changes since v1:
- binding: replace <4 24000> with <4000 20000>, instead of adding the
  correct pair and marking the old one deprecated.
- driver: drop the mapping from <4 24000> to the corrected range.

A device tree that still has <4 24000> now fails the binding check, and
probe stops with "range invalid".

Compile tested only; no relevant hardware available. The binding was
checked with make dt_binding_check and with test device trees:
<4000 20000> is accepted, <4 24000> is now rejected.

Link: https://lore.kernel.org/r/20260918122032.134947-1-arka@arkamondal.net

Arka Mondal (2):
  dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to 20 mA current range
  iio: dac: ad5758: Fix the 4 mA to 20 mA current range

 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 4 ++--
 drivers/iio/dac/ad5758.c                                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
--=20
2.55.0

