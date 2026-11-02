Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605671;
	b=f3eZFfxTcC/AuSo2LvJEdsQNhM9tUfP0nWXN4Pu7tBXlnp+GA/hA8/cJNWhegleBvuw9
	 kW5/z4pLoOO9QmLE1MRlI0EGCLtRYY1IIZecf4rRFGvfbEJwrIijCofnsKEGgyNu6KoNY
	 mijfQWuBSDcNWhRcQVULlU1pJDA6giKIyoPEx/04oPoTqTAlFFMFqOvCetqcHpvZ9VtJB
	 iLmr5mEf/qlF122lbEYARjLvI/0sloNsYA73MU4QHfHAAN/nhUMaowFx8huYHEbQIlUAF
	 sOvFVzrpN3P7D8LSy0eGTedqVadJ3VUCvAagYT7oqFh6QEXdAxLq2HHdyI2oing9yBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605671;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MIME-Autoconverted:
	 Content-Type;
	bh=ME2Cqg6qSz8PRLsZdr3Tn5bcHvcBRTnMAvRs195fxiM=;
	b=QCUM9sQCuJUZHbAlmRGvjiY417UWmlevq/1eKXXGQ7kxPD81mGEtsDddb/WQoQIyoEjU
	 6XKS1lF+5QdKQZ83zIR1MF5BfEBrEHLHv9K7BlbNfqJa50QYJKLgoB7heNcpLrBJxb0MA
	 CpjKP2jjGUspvHf/VcyGaFuzw3gq6+36iL+5XkK8sI9YsznOZx5en8P8h8r8zyKFDDUcM
	 /DWiD0PWsnu62awrH7kYrDY7H4UTmp7VwRT8nFqx1Xg5W5+MuU9f0PyyDWTR5EHSnBtC1
	 sBsfYh7DKPNkxdi4U2XS/eshwP4orFEubU9oPPn9bG3Wg+fKUEleFop4vBAj5gLND2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=gra4POX3;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b="QW/uBBom";
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210D606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D210D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=gra4POX3;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=QW/uBBom
DKIM-Signature: a=rsa-sha256; b=gra4POX39YwbZTA5PZhGKUncV6Zp994OHHzlTtuq45sKg6HkduIGhUyxz/wJIFk23rr9yv8rsuuV1MainkCa7n+qWOc7xNrLHgLLAjxueJ5PbdUrSAHxMdJDbww2uQf78w71fWqJHm1IYQixPl8ZMKzkdWIboyGUh9/+n36d9KUp0Nt6FZ7BVeOtJEn78xNCWImHWI0M39PqpppIBjOrUG07amnRy9WV9+RwaAbimzbklSitTMMCFweCL1oMajvjX1CpKlNsn2htE7Dbo1gcbOEPpELeDY6ypdYgsahmNM6dx8816BOQtaDkcm956u/pXlxGrTVcOlI5wmpwmVH3dA==; s=purelymail2; d=arkamondal.net; v=1; bh=kSHKm1nWBcQgSB/3l+sue+BQAl6lbrZWZ2hKP4X1zXQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=QW/uBBommH6pVDn2ig+V4wLwAlHffUQKH/gpld2lttq/X1R8NgF/zt84zlVhLWutE5vZH8t1XLu3srRUlDjcE28+xHf6Mh6KW+SonLWhfpeXssmT+yu02WVw30eOr2wr9bjUIIvB0qKCgBx5xjrCXt+BCDehcS6ZbHyZ+n4lbiK4lzmFXPfJXoteSWWPFMvk1tFB393nwKH/1cRfCCRplLlL8XpiCJHxZsZF1EbA/VqYAlkvy2TvR9v86OIcR70jtTv1UObn8n/o4k+tM3tP79dj1LYZqYwY1hIngTUtNE41J2T45HUNbxWZ+l+LN5oXkDVMPbQrkWMcnYQGvhLucw==; s=purelymail2; d=purelymail.com; v=1; bh=kSHKm1nWBcQgSB/3l+sue+BQAl6lbrZWZ2hKP4X1zXQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1445244709;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:18 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH 0/6] iio: Give the *_available attributes the names the core generates
Date: Mon,  2 Nov 2026 16:46:54 +0900
Message-ID: <20261102074700.63075-1-arka@arkamondal.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

An <attr>_available file takes its name from the attribute whose values
it lists. The core builds both names with __iio_chan_prefix_emit(),
called for the available attribute with the same shared_by
argument, so the prefix follows from where the value sits:
in_<type> plus any index or modifier for info_mask_separate,
in_<type> for info_mask_shared_by_type, and nothing at all for
info_mask_shared_by_all. The iio-channel-prefix KUnit suite covers each
of those cases.

Six drivers build their lists by hand with IIO_CONST_ATTR instead,
and ten of the eleven names they use have no prefix even though
none of those values is shared across all channels. Each of
the ten is a device level attribute paired with no channel, so
its list is reachable only under a name that does not describe
it. Documentation/ABI/testing/sysfs-bus-iio keeps bare names
for the shared-across-all case, sampling_frequency_available and
oversampling_ratio_available, and gives the prefixed form everywhere
else: in_accel_scale_available, in_illuminance_scale_available,
in_intensity_hardwaregain_available. Anything that looks for a list
beside the attribute it belongs to finds no such file.

These patches hand all eleven lists to read_avail() and delete the
custom attribute groups. The same was done for hts221 in
commit 003e99cf33e3 ("iio: humidity: hts221: report available values via re=
ad_avail()")
where "the incorrectly named in_humidity_oversampling_ratio_available
attribute is replaced by the standard
in_humidityrelative_oversampling_ratio_available name", so the shape is
not new. The names change as follows.

  isl29125   scale_available
             -> in_intensity_scale_available
  apds9960   proximity_scale_available
             -> in_proximity_scale_available
  apds9960   intensity_scale_available
             -> in_intensity_scale_available
  apds9960   integration_time_available
             -> in_intensity_integration_time_available
  max44009   illuminance_integration_time_available
             -> in_illuminance_integration_time_available
  max44000   illuminance_scale_available
             -> in_illuminance_scale_available
  max44000   illuminance_integration_time_available
             -> in_illuminance_integration_time_available
  hdc100x    temp_integration_time_available
             -> in_temp_integration_time_available
  hdc100x    humidityrelative_integration_time_available
             -> in_humidityrelative_integration_time_available
  hdc100x    out_current_heater_raw_available
             -> unchanged, this one was already right
  mpu3050    anglevel_scale_available
             -> in_anglvel_scale_available

Of the eleven lists, four print exactly the text they printed before and
six gain trailing decimals, because the core prints each value to the
full precision of its IIO_VAL_* type where the old strings were written
out by hand. apds9960's integration time, for one, becomes 0.028000
0.100000 0.200000 0.700000. The numbers are the same.

The eleventh is mpu3050, whose four values really do change. They were
computed against 2^16 while mpu3050_read_raw() divides by U16_MAX,
so the list never agreed with the channel: it offered 0.000122070
where in_anglvel_scale reports 0.000122072, and likewise for the other
three. Patch 6 builds the list from the same IIO_DEGREE_TO_RAD() terms
the read path uses, so the two cannot diverge again.

On who runs these parts: mpu3050 appears in eight in-tree device tree
files, covering Tegra 2 and 3 tablets, the APQ8060 Dragonboard and two
Ux500 phones, and hdc1080 in two, one of them an IBM BMC. apds9960,
max44000 and hdc100x also carry ACPI ids, so they turn up on x86
machines with no device tree at all. isl29125 and max44009 have no
in-tree user that I could find.

Compile tested only; I have none of this hardware. Patch 2 draws one
checkpatch spelling warning on a word inside its Fixes: subject. That
typo is in the 2015 commit being cited and has to stay, or the tag stops
matching the subject it names. I am happy to rebase on togreg or testing
if that is easier for you.

Arka Mondal (6):
  iio: light: isl29125: Report the scale list via read_avail()
  iio: light: apds9960: Report the available lists via read_avail()
  iio: light: max44009: Report the integration time via read_avail()
  iio: light: max44000: Report the available lists via read_avail()
  iio: humidity: hdc100x: Report the available lists via read_avail()
  iio: gyro: mpu3050: Fix the scale list and report it via read_avail()

 drivers/iio/gyro/mpu3050-core.c | 40 ++++++++++++---------
 drivers/iio/humidity/hdc100x.c  | 61 ++++++++++++++++++++++++---------
 drivers/iio/light/apds9960.c    | 56 ++++++++++++++++++++++--------
 drivers/iio/light/isl29125.c    | 29 +++++++++++-----
 drivers/iio/light/max44000.c    | 60 +++++++++++++++++++-------------
 drivers/iio/light/max44009.c    | 48 ++++++++++++++------------
 6 files changed, 193 insertions(+), 101 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
--=20
2.56.0

