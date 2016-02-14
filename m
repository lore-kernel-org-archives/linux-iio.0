Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 14 Feb 2016 15:09:08 -0800
Message-ID: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
Subject: [RFC] i2c_check_functionality and error code
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan et all,

Has anyone noticed that there is no clear consensus on which error
code to return when a i2c_check_functionality() check fails within the
probe function. I've seen so far ENODEV, ENOTSUPP, EOPNOTSUPP, EIO,
and ENOSYS in drivers/iio

Shouldn't these be made a standard value like -ENOTSUPP?

Thanks,

Matt
