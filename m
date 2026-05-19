Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2283DBD54
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178423; cv=none; b=mKpP7/KUgRRqBggyNEtCb6wyte2HmrAlD/f9Hyk2ui3g1Prh6x1wcAizg2N3ZpN1YXqE3qo+UP1tq8WFkugR2DMScGL2zhjXkrQBXHV/tNde67kiPW4yJn09WIzR9dMPJMPZXUQBhW+svkESnirfZIeuIT5JrW1/dzpzWQpVGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178423; c=relaxed/simple;
	bh=/04lsj148UCHnvyReQFHgCFaxGrNMYljW3erZxYleGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NJ4cCTQYQ9kxNXqGBtZnXu+hBfYa5OwZybntE261ghYxq/wAJejRxyWxbPOnSfaugtBEFq4UL5/tdzYnRJu5i4v+NKCqcDQznxGoFTx/iWbr5tCX9ikfLuX6WLbkLTy8ifJf6WjqGdp1qriogYTeYdQQV3BlutBpZE0ivVH8390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ILufsDca; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ILufsDca"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso16941065e9.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178418; x=1779783218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jINwlqit+0TqKb5BKVKufEfThnAal1KivxD736Chf6g=;
        b=ILufsDca3ZSohbHmgWIxoH/IX9rXbiB0/9CRrXLN5iJOGVEgLvpgT6Ym4rjLYhjDhU
         t+MrM+aiFOBj4M7+WoJb+UMhxEAAf/fRxMP708ZoynztDT/XhTAVcpz6cWVbGH9WNcG7
         LOAn0sU3xzgpdG69wnOcfeEzl2bzyVF2WV6GbHf0jH15reOtq25GI5s9AfO6eJNF3tTK
         9HFxGS+hpQZCA8Abn3rnx8H9xRTs74ffL0guyWryk1M/eUAMjDHJPC4wNAzCvo1V5ksl
         SRXG1J3ryyKLfMcGczx44dqzh0zbr7p5vmHLL+Juj7J7FUt3qyRejiA7cYPRLmaYGhHi
         r2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178418; x=1779783218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jINwlqit+0TqKb5BKVKufEfThnAal1KivxD736Chf6g=;
        b=MiI05/zn7OIY6R1NG9dpLtzXsy+ApylNKRJ4zkaZBsSkjn3R4eK4UE+L/xpKzqTxRq
         W0W4l2pEyRJB6iexXbcddJSTFR/yYsIyMEsMQcAmtwKbCnLsABfC/Q2DLKL4biOMErSz
         ImVupxXJE6Q9LTYG0nZPXHJMqSsMgarkNOKhu6GIaOuigAwH2Xi1TjBn4zDpVxs/A+5U
         aRYh4x9tofFyYLZ3ODcVwVlBiFNue0X6guOBHJ9K+Qtw7CPu+NX/hFGofyNpc8eIqkOm
         ZBl5A+w1V0/Disq6OboLZDXmiUSokCAwBXIGATlpaiWzCfortJf5g0s4WupV5fGWnB0b
         G8Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+S4vNWYCRfcJSxB/8rwCaQD6EgnxPFmgp/ZDVRtZKXBcPG5ZwmeHcVHYgOliAbYIBkO6DKFMdzxIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJsJcdzOBl8ZdFIt+/3zBiZPHwpcZqzt1Ix+UsfgxSowAGLDC
	KliuZn5Vk/9MAp6bpuKgkHgT3dz4wxUhs1cxJyQhQ1/tNJEieXGWjheQ7P84PAk6huY=
X-Gm-Gg: Acq92OG/4FBc/K0qyVkCCoPoc54EhRQ1oWTTUFn2uohLOqIGK1tPS3iVa+7v+aU42o6
	gCIKsHAp9cwnvvVsx4RL9zYgsjC/E8UoGrqQ5ss/IwHX/H1ORKxIvfw74pl4iSgG/blqRATmOEY
	rUi+WFdPKIBpsCDXuUqG3oaWt4aSp/HyOcUBt6VJNGFyA5mqxJbQkKI4gS3nx2UcbtZo9UYx6NV
	cNDwRrVzog38bgAQkWNl/vikJz/d1N3PHB5Wj6MQIn+JsZBm35wmfB3395xbjvWzWMIyVH3kGq0
	RWOQ1+cpwPRsOkbmwyp4uouFe0efUTIbV9gWAV97Y2ZpgXAMJdt2w0E0yti4O/GlkxpNsKDVGGR
	rCv5yom/lSylOacbjlvHGxUab7ZVaXNJ5Agp5wlY8D97EU8cSAR6l6ll6D+e3v2/OAbA2+ajzHe
	B6CyHtA5efnLgeyjJQANAAwMWlDmAc+XqIpx4yFWv2w47xzeIekDDi/65SLuy9gq+b5RsYBv027
	nRlbk9zLUoAV9Q=
X-Received: by 2002:a05:600c:1e24:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48fe63182a2mr288422815e9.26.1779178417219;
        Tue, 19 May 2026 01:13:37 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ed2f738sm42741053f8f.16.2026.05.19.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	Christian Eggers <ceggers@arri.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	=?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
	Eddie James <eajames@linux.ibm.com>,
	Petar Stoykov <petar.stoykov@prodrive-technologies.com>,
	Song Qiang <songqiang1304521@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Crt Mori <cmo@melexis.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chuang Zhu <git@chuang.cz>,
	Kyle Hsieh <kylehsieh1995@gmail.com>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Sander Vanheule <sander@svanheule.net>,
	David Jander <david@protonic.nl>,
	Andrew Davis <afd@ti.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Tomas Borquez <tomasborquez13@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Aldo Conte <aldocontelk@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Gabriel Almeida <gabrielsousa230@gmail.com>,
	Gabriela Victor <gabevictor333@gmail.com>,
	Beatriz Viana Costa <beatrizvianacosta16@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Ben Collins <bcollins@watter.com>
Subject: [PATCH v2 0/7] iio: Rework i2c_device_id initialisation
Date: Tue, 19 May 2026 10:13:02 +0200
Message-ID: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13972; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/04lsj148UCHnvyReQFHgCFaxGrNMYljW3erZxYleGk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBuPblkwscZM1DHRL8k5fXC/eTAqnRY5eAooB KS0yce3VtqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwbjwAKCRCPgPtYfRL+ TqH2B/4/2f02FSa4pPaA1OFQLhUHJFLc4PskMBqg8ut7OrVgBoRSnPO3e67Xq9WTkyfI8x+suVJ nV2s2rhg+393jihFD0CxoQOcqFBu02puui0VYhOilSoWaAbzT2+60S/pLf6oj5ZPct5RynzVWDV GPeRRglyWKX7U/UPrE+tFYo30NAa6gW7Pi9l8xolNzUt7zKbQM/adaL+TDJfmWF88BDoQgRaw94 qXrdXYAEJf9WhA864pZuExx9LsHn9cNMCyz9TRCOp47XFbAq9Pzb6NLegTOAVpwbrY853y/iJsd xae24vsY+eh7HWqg4I7/jszOorDkl++bgFoxnv8uSnjJdf/+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of this series is to convert all i2c_device_id arrays to
use named initialization. This is better readable and a prepartion for
further cleanups involving changes to i2c_device_id.

Changes since v1:

 - Drop driver data from more drivers, v1 only had the first patch that
   is unmodified. Patches #2 to #6 are new and are handling more complex
   simplifications in one driver per patch.
 - Also convert i2c_device_id entries that don't have assignments for
   .driver_data in patch #7.

Patch #1 was already applied to the testing branch, I included it here
again for completeness.

Patch #7 got a Reviewed-by tag by Linus Walleij. Given the changes in
that patch I didn't apply it here.

There is still the patch opportunity in the sx9310 driver pointed out by
Jonathan in the v1 thread. I considered that too complex to include it
in this cleanup series and wasn't confident to not break the driver
given I don't have a device to test. I think the whole .check_whoami()
callback should be dropped from all drivers using sx_common and if the
whoami register should be checked, just do it in .probe().

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (7):
  iio: Drop unused driver_data in four i2c drivers
  iio: accel: bmc150: Explicitly set .driver_data
  iio: adc: ad7091r5: Simplify driver_data handling
  iio: dac: max5821: Drop unused i2c driver data
  iio: proximity: sx9324: Drop unused driver data
  iio: proximity: sx9360: Drop unused driver data
  iio: Initialize i2c_device_id arrays using member names

 drivers/iio/accel/adxl345_i2c.c               |  4 +-
 drivers/iio/accel/adxl355_i2c.c               |  4 +-
 drivers/iio/accel/adxl367_i2c.c               |  2 +-
 drivers/iio/accel/adxl372_i2c.c               |  4 +-
 drivers/iio/accel/adxl380_i2c.c               |  8 +-
 drivers/iio/accel/bma180.c                    | 10 +-
 drivers/iio/accel/bma220_i2c.c                |  2 +-
 drivers/iio/accel/bma400_i2c.c                |  2 +-
 drivers/iio/accel/bmc150-accel-i2c.c          | 20 ++--
 drivers/iio/accel/bmi088-accel-i2c.c          |  6 +-
 drivers/iio/accel/da280.c                     |  6 +-
 drivers/iio/accel/da311.c                     |  2 +-
 drivers/iio/accel/dmard06.c                   |  6 +-
 drivers/iio/accel/dmard09.c                   |  2 +-
 drivers/iio/accel/dmard10.c                   |  2 +-
 drivers/iio/accel/fxls8962af-i2c.c            |  8 +-
 drivers/iio/accel/kxcjk-1013.c                | 10 +-
 drivers/iio/accel/kxsd9-i2c.c                 |  2 +-
 drivers/iio/accel/mc3230.c                    |  4 +-
 drivers/iio/accel/mma7455_i2c.c               |  4 +-
 drivers/iio/accel/mma7660.c                   |  2 +-
 drivers/iio/accel/mma8452.c                   | 12 +--
 drivers/iio/accel/mma9551.c                   |  2 +-
 drivers/iio/accel/mma9553.c                   |  2 +-
 drivers/iio/accel/mxc4005.c                   |  4 +-
 drivers/iio/accel/mxc6255.c                   |  4 +-
 drivers/iio/accel/st_accel_i2c.c              | 52 +++++-----
 drivers/iio/accel/stk8312.c                   |  4 +-
 drivers/iio/accel/stk8ba50.c                  |  2 +-
 drivers/iio/adc/ad7091r5.c                    | 12 +--
 drivers/iio/adc/ad7291.c                      |  2 +-
 drivers/iio/adc/ad799x.c                      | 16 ++--
 drivers/iio/adc/gehc-pmc-adc.c                |  2 +-
 drivers/iio/adc/ina2xx-adc.c                  | 12 +--
 drivers/iio/adc/ltc2309.c                     |  4 +-
 drivers/iio/adc/ltc2471.c                     |  4 +-
 drivers/iio/adc/ltc2485.c                     |  2 +-
 drivers/iio/adc/ltc2497.c                     |  4 +-
 drivers/iio/adc/max34408.c                    |  4 +-
 drivers/iio/adc/mcp3422.c                     | 16 ++--
 drivers/iio/adc/nau7802.c                     |  2 +-
 drivers/iio/adc/pac1921.c                     |  2 +-
 drivers/iio/adc/rohm-bd79124.c                |  2 +-
 drivers/iio/adc/ti-adc081c.c                  |  6 +-
 drivers/iio/adc/ti-ads1015.c                  |  6 +-
 drivers/iio/adc/ti-ads1100.c                  |  4 +-
 drivers/iio/adc/ti-ads1119.c                  |  2 +-
 drivers/iio/adc/ti-ads7138.c                  |  4 +-
 drivers/iio/adc/ti-ads7924.c                  |  2 +-
 drivers/iio/cdc/ad7150.c                      |  6 +-
 drivers/iio/cdc/ad7746.c                      |  6 +-
 drivers/iio/chemical/ags02ma.c                |  2 +-
 drivers/iio/chemical/ams-iaq-core.c           |  2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c       |  6 +-
 drivers/iio/chemical/atlas-sensor.c           | 10 +-
 drivers/iio/chemical/bme680_i2c.c             |  2 +-
 drivers/iio/chemical/ccs811.c                 |  4 +-
 drivers/iio/chemical/ens160_i2c.c             |  2 +-
 drivers/iio/chemical/sgp30.c                  |  4 +-
 drivers/iio/chemical/sgp40.c                  |  2 +-
 drivers/iio/chemical/sps30_i2c.c              |  2 +-
 drivers/iio/chemical/vz89x.c                  |  4 +-
 drivers/iio/dac/ad5064.c                      | 94 +++++++++----------
 drivers/iio/dac/ad5380.c                      | 32 +++----
 drivers/iio/dac/ad5446-i2c.c                  | 12 +--
 drivers/iio/dac/ad5696-i2c.c                  | 32 +++----
 drivers/iio/dac/ds4424.c                      |  8 +-
 drivers/iio/dac/m62332.c                      |  2 +-
 drivers/iio/dac/max517.c                      | 10 +-
 drivers/iio/dac/max5821.c                     |  6 +-
 drivers/iio/dac/mcp4725.c                     |  4 +-
 drivers/iio/dac/mcp4728.c                     |  2 +-
 drivers/iio/dac/mcp47feb02.c                  | 48 +++++-----
 drivers/iio/dac/ti-dac5571.c                  | 22 ++---
 drivers/iio/gyro/bmg160_i2c.c                 |  6 +-
 drivers/iio/gyro/fxas21002c_i2c.c             |  2 +-
 drivers/iio/gyro/itg3200_core.c               |  2 +-
 drivers/iio/gyro/mpu3050-i2c.c                |  2 +-
 drivers/iio/gyro/st_gyro_i2c.c                | 18 ++--
 drivers/iio/health/afe4404.c                  |  2 +-
 drivers/iio/health/max30100.c                 |  2 +-
 drivers/iio/health/max30102.c                 |  6 +-
 drivers/iio/humidity/am2315.c                 |  2 +-
 drivers/iio/humidity/ens210.c                 | 12 +--
 drivers/iio/humidity/hdc100x.c                | 12 +--
 drivers/iio/humidity/hdc2010.c                |  4 +-
 drivers/iio/humidity/hdc3020.c                |  6 +-
 drivers/iio/humidity/hts221_i2c.c             |  2 +-
 drivers/iio/humidity/htu21.c                  |  4 +-
 drivers/iio/humidity/si7005.c                 |  4 +-
 drivers/iio/humidity/si7020.c                 |  4 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c           |  4 +-
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  4 +-
 drivers/iio/imu/bmi323/bmi323_i2c.c           |  2 +-
 drivers/iio/imu/bno055/bno055_i2c.c           |  2 +-
 drivers/iio/imu/fxos8700_i2c.c                |  2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 14 +--
 .../iio/imu/inv_icm45600/inv_icm45600_i2c.c   | 16 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 36 +++----
 drivers/iio/imu/kmx61.c                       |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   | 48 +++++-----
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  4 +-
 drivers/iio/light/adjd_s311.c                 |  2 +-
 drivers/iio/light/adux1020.c                  |  2 +-
 drivers/iio/light/al3000a.c                   |  2 +-
 drivers/iio/light/al3010.c                    |  2 +-
 drivers/iio/light/al3320a.c                   |  2 +-
 drivers/iio/light/apds9160.c                  |  2 +-
 drivers/iio/light/apds9300.c                  |  2 +-
 drivers/iio/light/apds9960.c                  |  2 +-
 drivers/iio/light/as73211.c                   |  4 +-
 drivers/iio/light/bh1745.c                    |  2 +-
 drivers/iio/light/bh1750.c                    | 10 +-
 drivers/iio/light/bh1780.c                    |  2 +-
 drivers/iio/light/cm3232.c                    |  2 +-
 drivers/iio/light/cm3323.c                    |  2 +-
 drivers/iio/light/cm36651.c                   |  2 +-
 drivers/iio/light/gp2ap002.c                  |  2 +-
 drivers/iio/light/gp2ap020a00f.c              |  2 +-
 drivers/iio/light/isl29018.c                  |  6 +-
 drivers/iio/light/isl29028.c                  |  4 +-
 drivers/iio/light/isl29125.c                  |  2 +-
 drivers/iio/light/isl76682.c                  |  2 +-
 drivers/iio/light/jsa1212.c                   |  2 +-
 drivers/iio/light/ltr390.c                    |  2 +-
 drivers/iio/light/ltr501.c                    |  8 +-
 drivers/iio/light/ltrf216a.c                  |  4 +-
 drivers/iio/light/lv0104cs.c                  |  2 +-
 drivers/iio/light/max44000.c                  |  2 +-
 drivers/iio/light/max44009.c                  |  2 +-
 drivers/iio/light/noa1305.c                   |  2 +-
 drivers/iio/light/opt3001.c                   |  4 +-
 drivers/iio/light/opt4001.c                   |  4 +-
 drivers/iio/light/opt4060.c                   |  2 +-
 drivers/iio/light/pa12203001.c                |  2 +-
 drivers/iio/light/rpr0521.c                   |  2 +-
 drivers/iio/light/si1133.c                    |  2 +-
 drivers/iio/light/si1145.c                    | 14 +--
 drivers/iio/light/st_uvis25_i2c.c             |  2 +-
 drivers/iio/light/stk3310.c                   |  8 +-
 drivers/iio/light/tcs3414.c                   |  2 +-
 drivers/iio/light/tcs3472.c                   |  2 +-
 drivers/iio/light/tsl2563.c                   |  8 +-
 drivers/iio/light/tsl2583.c                   |  6 +-
 drivers/iio/light/tsl2772.c                   | 22 ++---
 drivers/iio/light/tsl4531.c                   |  2 +-
 drivers/iio/light/us5182d.c                   |  2 +-
 drivers/iio/light/vcnl4000.c                  | 14 +--
 drivers/iio/light/vcnl4035.c                  |  2 +-
 drivers/iio/light/veml3235.c                  |  2 +-
 drivers/iio/light/veml6030.c                  |  6 +-
 drivers/iio/light/veml6040.c                  |  2 +-
 drivers/iio/light/veml6046x00.c               |  2 +-
 drivers/iio/light/veml6070.c                  |  2 +-
 drivers/iio/light/veml6075.c                  |  2 +-
 drivers/iio/light/vl6180.c                    |  2 +-
 drivers/iio/light/zopt2201.c                  |  2 +-
 drivers/iio/magnetometer/af8133j.c            |  2 +-
 drivers/iio/magnetometer/ak8974.c             |  8 +-
 drivers/iio/magnetometer/ak8975.c             | 14 +--
 drivers/iio/magnetometer/bmc150_magn_i2c.c    |  6 +-
 drivers/iio/magnetometer/hmc5843_i2c.c        |  8 +-
 drivers/iio/magnetometer/mag3110.c            |  2 +-
 drivers/iio/magnetometer/mmc35240.c           |  2 +-
 drivers/iio/magnetometer/mmc5633.c            |  4 +-
 drivers/iio/magnetometer/si7210.c             |  2 +-
 drivers/iio/magnetometer/st_magn_i2c.c        | 18 ++--
 drivers/iio/magnetometer/tlv493d.c            |  2 +-
 drivers/iio/magnetometer/tmag5273.c           |  2 +-
 drivers/iio/magnetometer/yamaha-yas530.c      |  8 +-
 drivers/iio/potentiometer/ad5272.c            | 10 +-
 drivers/iio/potentiometer/ds1803.c            |  8 +-
 drivers/iio/potentiometer/tpl0102.c           |  8 +-
 drivers/iio/potentiostat/lmp91000.c           |  4 +-
 drivers/iio/pressure/abp060mg.c               | 90 +++++++++++-------
 drivers/iio/pressure/abp2030pa_i2c.c          |  2 +-
 drivers/iio/pressure/adp810.c                 |  2 +-
 drivers/iio/pressure/bmp280-i2c.c             | 12 +--
 drivers/iio/pressure/dlhl60d.c                |  4 +-
 drivers/iio/pressure/dps310.c                 |  2 +-
 drivers/iio/pressure/hp03.c                   |  2 +-
 drivers/iio/pressure/hp206c.c                 |  2 +-
 drivers/iio/pressure/hsc030pa_i2c.c           |  2 +-
 drivers/iio/pressure/icp10100.c               |  2 +-
 drivers/iio/pressure/mpl115_i2c.c             |  2 +-
 drivers/iio/pressure/mpl3115.c                |  2 +-
 drivers/iio/pressure/mprls0025pa_i2c.c        |  2 +-
 drivers/iio/pressure/ms5611_i2c.c             |  4 +-
 drivers/iio/pressure/ms5637.c                 |  8 +-
 drivers/iio/pressure/rohm-bm1390.c            |  2 +-
 drivers/iio/pressure/sdp500.c                 |  2 +-
 drivers/iio/pressure/st_pressure_i2c.c        | 16 ++--
 drivers/iio/pressure/t5403.c                  |  2 +-
 drivers/iio/pressure/zpa2326_i2c.c            |  2 +-
 drivers/iio/proximity/aw96103.c               |  4 +-
 drivers/iio/proximity/hx9023s.c               |  2 +-
 drivers/iio/proximity/isl29501.c              |  2 +-
 drivers/iio/proximity/mb1232.c                | 14 +--
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  4 +-
 drivers/iio/proximity/rfd77402.c              |  2 +-
 drivers/iio/proximity/srf08.c                 |  6 +-
 drivers/iio/proximity/sx9310.c                |  4 +-
 drivers/iio/proximity/sx9324.c                |  6 +-
 drivers/iio/proximity/sx9360.c                |  8 +-
 drivers/iio/proximity/sx9500.c                |  2 +-
 drivers/iio/proximity/vl53l0x-i2c.c           |  2 +-
 drivers/iio/proximity/vl53l1x-i2c.c           |  2 +-
 drivers/iio/temperature/max30208.c            |  2 +-
 drivers/iio/temperature/mcp9600.c             |  4 +-
 drivers/iio/temperature/mlx90614.c            |  4 +-
 drivers/iio/temperature/mlx90632.c            |  2 +-
 drivers/iio/temperature/mlx90635.c            |  2 +-
 drivers/iio/temperature/tmp006.c              |  2 +-
 drivers/iio/temperature/tmp007.c              |  2 +-
 drivers/iio/temperature/tmp117.c              |  4 +-
 drivers/iio/temperature/tsys01.c              |  2 +-
 drivers/iio/temperature/tsys02d.c             |  2 +-
 217 files changed, 708 insertions(+), 696 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

