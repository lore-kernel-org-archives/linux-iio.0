Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F923D8137;
	Fri,  5 Jun 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654139; cv=none; b=EPWiGS+/Bz7daDAhqt/13Gosygfv5HoKOnNkhotZGXmoKcoCYvc5y3OAmV6fCIgVIYTpskMaA29eq+ib96MyEf0hP3JHexlrzBt9C+6HQYtzCugadk0v0ATFptuaDfZHuFrMdvv2lawkhFCNSNKylcuXQUAZNDDfN/IhVaOGbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654139; c=relaxed/simple;
	bh=O0r39KWtJcvvr6HrSfODHfJ63Zbmr6L7WBKTJfoeZCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FAV3QR24KHHUOjFhL6UHWy6+mn+q6bv2kZFRIkSuaLK6b+tRsJmz7WfBCTM24VfYUIRmO20w4uI15B/V4xdVi5/2x9BUM40h0chuJK6ekm7X3YE3TbBc5ot6i39dcLP30mnQVr6jzyamMlqGq5ury8qn6oldU9Nt5L3vcXnfY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=sEPXu05Q; arc=none smtp.client-ip=136.144.136.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="sEPXu05Q"
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4gWxwX6hpkzY76h8;
	Fri,  5 Jun 2026 12:08:44 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4gWxwX28h9z3R3p03;
	Fri,  5 Jun 2026 12:08:44 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: jic23@kernel.org,
	linusw@kernel.org,
	denis.ciocca@st.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 0/3] iio: lsm303dlh-magn: endianness + boot-time fullscale selection
Date: Fri,  5 Jun 2026 12:08:40 +0200
Message-ID: <cover.1780652883.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780654124; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=h659qkI7QXLh60/Bn1eXJ0SYXQqI0f9z1CMZW4J+C6s=;
 b=sEPXu05Qye/KPtUfxhPxMdWMtPTttcUGoCVAB4vFZ38AB1EOvwfWZAk0hhDYarhh+bQlbv
 SthPbehivLxJK7dZVOQhBG/eWds3tvH2fJmhMncXLKeJGMW5hswZJ/BNjIaM006mJpnEIv
 r18NyC3v9davit4lQvYHtnbm3Qxcyi2ZKvNuVJN+/mllb+mhpHAqr/YH58PxCrj/teHEVm
 H/VRuNTjIN5NHtrUmSpnJ9s3//ococxyZPpNxJktPRCgX4QcgxC+qCIfGM+ea7/5EE4PR7
 /ChaQGAbNBPuOeN5dOmu7pzf7A9ah2ug3sERfbbCVqBzNJG1yqwI+blRE4eHLw==
X-Report-Abuse-To: abuse@transip.nl

This series fixes two independent issues that together prevent the
LSM303DLH magnetometer from delivering usable readings out of the
box on at least the HP TouchPad (apq8060), and adds a small generic
extension to the ST sensors device-tree binding to allow boards to
declare a non-default initial full-scale.

PATCH 1/3 fixes st_sensors_core's read_axis_data() helper to honour
the channel's declared scan_type.endianness. The helper has
unconditionally decoded multi-byte results as little-endian since
it was introduced. Every other in-tree ST sensor declares IIO_LE
and was unaffected, but the LSM303DLH magnetometer publishes its
X / Y / Z words as big-endian pairs (high byte at the lower
register address, 0x03 / 0x05 / 0x07) and its channel specs in
st_magn_core.c correctly declare IIO_BE. The mismatch swapped the
high and low bytes of every magnetometer sample. The fix is generic
and only affects the IIO_BE branch; existing IIO_LE consumers are
untouched.

PATCH 2/3 adds an optional `st,fullscale-mg` device-tree property
to the ST sensors binding. The driver core hardcodes fs_avl[0] (the
highest-sensitivity range) as the starting full-scale, which is the
right default for a desk-noise floor but leaves no margin for
boards that pick up DC bias from nearby PCB structures. The
property lets a board declare the initial range in milligauss, with
the driver falling back to its built-in default on absence or on an
unsupported value. The property is purely additive and no in-tree
DTS is affected.

PATCH 3/3 parses st,fullscale-mg in the magnetometer common probe
and selects the matching fs_avl entry. The LSM303DLH on the HP
TouchPad picks up enough DC bias from the surrounding power planes
that the chip-default +/-1.3 G range saturates the X axis to the
chip's 0xF000 overflow sentinel on every sample, while Y and Z fall
within range. Empirically any fs_avl >= 1 (+/-1.9 G and up) works;
on tenderloin the appropriate value is 2500 mg (+/-2.5 G).

Before this series, on the HP TouchPad with the magnetometer flat
on a stable surface (sysfs in_magn_x_raw / in_magn_y_raw /
in_magn_z_raw, 15 reads at 200 ms intervals):

  X = 240             (high byte stuck at 0x00, low byte = 0xF0)
  Y = 12032..23296    (apparent random walk over ~11 K range)
  Z = -16128..-9728   (apparent random walk over ~6 K range)

After PATCH 1/3 alone (endianness fix), the chip reports its real
overflow sentinel for X:

  X = -4096           (= 0xF000, chip's saturation marker)
  Y =  91..103        (tight, sensible field reading)
  Z = 173..184        (tight, sensible field reading)

After the full series with st,fullscale-mg=2500 on tenderloin:

  X = -384..-403      (tight, sensible field reading)
  Y =   47..58
  Z =   96..108

Spans of 14..20 raw counts at scale 0.000670 G/LSB across all axes,
matching expected chip noise around the ambient DC bias.

PATCH 1/3 is a standalone bug fix and could be applied on its own
even if the binding extension is rejected. PATCHES 2/3 and 3/3 form
a unit.


Herman van Hazendonk (3):
  iio: common: st_sensors: honour channel endianness in read_axis_data
  dt-bindings: iio: st,st-sensors: add st,fullscale-mg
  iio: magnetometer: st_magn: honour st,fullscale-mg DT property

 .../bindings/iio/st,st-sensors.yaml           | 18 ++++++++++
 .../iio/common/st_sensors/st_sensors_core.c   | 19 +++++++---
 drivers/iio/magnetometer/st_magn_core.c       | 35 +++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.43.0

