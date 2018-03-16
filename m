Return-Path: <SRS0=D4ap=GG=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 16 Mar 2018 11:02:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316080257.dlglfjespmltwo3u@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

You're right that there is a bug but this is not the right fix.

The ade7854_i2c_write_reg_32() function returns 6 on success which makes
no sense.  It should be zero or negative error codes.  All the write_reg
functions in drivers/staging/iio/meter/ade7854-i2c.c have the same bug.

Please, fix that instead and leave ade7854_initial_setup() alone.

regards,
dan carpenter
