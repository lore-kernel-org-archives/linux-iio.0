Return-Path: <SRS0=M3iC=6C=gmail.com=fransklaver@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170629170352.11264-4-masneyb@onstation.org>
References: <20170629170352.11264-1-masneyb@onstation.org> <20170629170352.11264-4-masneyb@onstation.org>
From: Frans Klaver <fransklaver@gmail.com>
Date: Thu, 29 Jun 2017 21:26:37 +0200
Message-ID: <CAH6sp9N2-Z5qMmBTJ5-kyBtQ58wAXXC3JSO6YfBC=f+ZY4sucw@mail.gmail.com>
Subject: Re: [PATCH 3/6] staging: iio: tsl2x7x: remove tsl2x7x_i2c_read()
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	driverdevel <devel@driverdev.osuosl.org>, lars@metafoo.de,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
	knaack.h@gmx.de
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jun 29, 2017 at 7:03 PM, Brian Masney <masneyb@onstation.org> wrote:
> tsl2x7x_i2c_read() would call i2c_smbus_write_byte() and
> i2c_smbus_read_byte(). These two i2c functions can be replaced with a
> single call to i2c_smbus_read_byte_data(). This patch removes the
> tsl2x7x_i2c_read() function and replaces all occurances with a call to
> i2c_smbus_read_byte_data().

s,occurances,occurrences,

Frans
