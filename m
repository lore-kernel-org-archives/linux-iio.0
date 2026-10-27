Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117957;
	b=rk3B2O1C1axRO9c7MIaZS1m9MkKZtsw2c1Lhel5PGFh7rqXZ4Oek8Bf7c78VqioHoa+l
	 NeMaCTDT+eZ7ldxexLDcCCoAQP+m0CKSYBuyDNG/+2zJX8mb7Lrum96KgyZETopdSYvuq
	 EcmOjWcFJtIaVgMOtAHjPC9p2kRJW1wOtJ1UULe9jMxEBvHTuQHYI+h4vGa9BDhT1lU+v
	 BtmoWNeQqPLl0x9UXcdQlmee3DVDxap6WkPDQKcwp7GncKIH3iVC0Msnitbb3iqC60SpE
	 4NwgTLf0tnkVNWlC6Hjv1VCmqE8OHARdV13Ww4Crm+7Eoi/JhTrlrzM8vNA8qy1TcOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117957;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yYxEBj9tY6IMW1wOMmxEcRW7PKBex4syji9I0WIPUl8=;
	b=IUhTx1gJinVwAhY7+4jZjag8by5ZppO2EOZEK8HOyXEyPit42CciHeb6nc7AAkoxhQ1s
	 KFp5CwTGuzncKVD+zV9xH/GHKp3/Ea8DVlWaFWcg3aGMn942vzrFERVczmIELrBxJj7NH
	 eiGCWiHBh1DURmIta2IeReSKWnePYrGtNYFDvi28bmBSs5pyXBFHFG81mi+YJXnNLxy5Z
	 GiRYeC7zeQayK2G2l7Pv6qcXbJzkJOZDBq1QriP/l5ZXvlOBl5GKxKiQl2Cu5bkSt7T9/
	 yIfFo1OJgxQ7cCErSHSqYPt+wBqbzpSHZVjRK6GRrxW4XysJist7PxBwdhHNaM0KCng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0wNQRnqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923E606A31B;
	Tue, 27 Oct 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0wNQRnqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A441F01828;
	Tue, 27 Oct 2026 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117956;
	bh=yYxEBj9tY6IMW1wOMmxEcRW7PKBex4syji9I0WIPUl8=;
	h=From:Subject:Date:To:Cc;
	b=0wNQRnqZ/YgHQiWfrqRmLN6Ejh46KJ8xDnDs5ep00NQ/+sr2uGWMZDXCv/gsYjp9y
	 V6A2HL8JgJjw1I9NyVYv85LKFx3Mr8yjPKkpI0vqY9QUPL6wzqGWsWdmDFU+xQZv9I
	 bHJrC6zo3hYhhZBdEI+/EEisyLm+hHlRVo5is9nI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/15] IIO: a bunch of llm-found fixes
Date: Tue, 27 Oct 2026 17:19:04 +0100
Message-Id: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3ZycXF2gTJFubmZxsm5mZr5ukoWJaYqlUZKlsWmiElBfQVFqWmY
 F2MzoWAi/uDQpKzW5BGSQUm0tADY19Yl1AAAA
X-Change-ID: 20261027-llm-char-misc-iio-b845d92b935a
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Paul Cercueil <paul@crapouillou.net>, Leonard Crestez <cdleonard@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <demonsingur@gmail.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Renato Lui Geh <renatogeh@gmail.com>, 
 Ramona Bolboaca <ramona.bolboaca@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Edmund Berenson <edmund.berenson@emlix.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Matheus Silveira <matheus.feitosa@usp.br>, 
 Lucas Rabaquim <lucas.rabaquim@usp.br>, 
 Stepan Ionichev <sozdayvek@gmail.com>, Joe Sandom <joe.g.sandom@gmail.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Shi Hao <i.shihao.999@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Siratul Islam <email@sirat.me>, Vlad Dogaru <ddvlad@gmail.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jyoti Bhayana <jbhayana@google.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=GXyeA38u80AxXxDwlLQA0+99Rhy5FmZ2ae6hVETpqR4=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjN8fXlrrr7ufRtdVvYpfyz/v7xpbdKdfV1Tk/++u
 iJDt2ZnRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzEagXDXNFP1zz0/6zj9/E1
 nnZXpEG9mbG/k2Ge7SNHzxdNZk/MTXW/hU/dH5b4NuoMAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Here's a series of some small llm-found fixes that have been sent to me
recently.  Most of them are just minor bugfixes and locking cleanups,
but they are good to have from what I can tell.

Submitting them here to get a solid Sashiko run.  If they seem sane, and
you want me to take these directly through my char-misc tree I can do
that now, or I can gladly wait for you to resend them if you wish to do
that instead.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Josef Bacik (15):
      iio: buffer: let the block keep its DMA fence
      iio: trigger: fail the attach if no sub-IRQ is left
      iio: accel: adxl367: don't stay in standby on -EINVAL
      iio: accel: adxl380: don't stay in standby on -EINVAL
      iio: adc: check the result of ad_sd_init()
      iio: adc: ad7923: add the AD7927 to the SPI ID table
      iio: addac: ad74413r: fix the values of set_multiple
      iio: light: apds9306: push events to the IIO device
      iio: light: tsl2591: don't divide by zero in the dark
      iio: light: tsl2591: don't divide by zero with low gain
      iio: hid-sensors: fix a division by zero
      iio: imu: inv_mpu6050: don't disable the IRQ under lock
      iio: proximity: sx9500: hand on probe deferral of GPIOs
      iio: scmi: use 64-bit divisions for rates and intervals
      iio: sx9310: use the data of the I2C table

 drivers/iio/accel/adxl367.c                           | 11 ++++++++++-
 drivers/iio/accel/adxl380.c                           | 11 ++++++++++-
 drivers/iio/adc/ad7780.c                              |  4 +++-
 drivers/iio/adc/ad7791.c                              |  4 +++-
 drivers/iio/adc/ad7793.c                              |  4 +++-
 drivers/iio/adc/ad7923.c                              |  1 +
 drivers/iio/adc/max11205.c                            |  4 +++-
 drivers/iio/addac/ad74413r.c                          |  2 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c    |  5 ++++-
 drivers/iio/common/scmi_sensors/scmi_iio.c            | 12 ++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c            | 19 +++++++++++++++++--
 drivers/iio/industrialio-buffer.c                     | 15 +++++++--------
 drivers/iio/industrialio-trigger.c                    |  1 +
 drivers/iio/light/apds9306.c                          |  2 +-
 drivers/iio/light/tsl2591.c                           | 17 +++++++++++++++--
 drivers/iio/proximity/sx9310.c                        |  2 +-
 drivers/iio/proximity/sx9500.c                        | 16 ++++++++++++----
 17 files changed, 96 insertions(+), 34 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261027-llm-char-misc-iio-b845d92b935a

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

