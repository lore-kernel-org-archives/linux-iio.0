Return-Path: <pratik.prajapati12@gmail.com>
MIME-Version: 1.0
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Sat, 23 Jul 2016 19:06:39 +0530
Message-ID: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com>
Subject: How to support multiple chips in single driver
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

I want to add the threshold, event handling and interrupts support in
vcnl4000 driver but those functionalities are not supported in
vcnl4000, but supported in vcnl4010 .

Do we have an example (IIO driver) of supporting multiple chips in a
single driver?

Note* - vcnl4010 is superset of vcnl4000

Best Regards,
Pratik Prajapati
