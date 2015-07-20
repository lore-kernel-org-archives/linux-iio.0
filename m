Return-Path: <marek.belisko@gmail.com>
MIME-Version: 1.0
Date: Mon, 20 Jul 2015 08:57:12 +0200
Message-ID: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
Subject: twl6030-gpadc support for twl6037
From: Belisko Marek <marek.belisko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, axel.lin@ingics.com, linux-iio@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi all,

I'm trying to figure out what is relation between palmas mfd driver
and twl-core for twl603x devices.
twl-core driver seems to be older than palmas driver but seems both
export same functionality (except that palmas have defined structs for
gpadc but functionality is missing). My main focus is to add support
for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
using twl-core for twl6030 and twl6032. Adding twl6037 support should
be straightforward but dts file used in omap5-uevm using palmas driver
and not twl6030. So it's completely confusing to me how to proceed or
which direction is correct. Seems I'm missing some parts of puzzle ;)
Thanks for any hints.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
