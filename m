Return-Path: <SRS0=O4k9=GG=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 16 Mar 2018 10:59:46 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
 <20180316080257.dlglfjespmltwo3u@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316080257.dlglfjespmltwo3u@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On 03/16, Dan Carpenter wrote:
> You're right that there is a bug but this is not the right fix.
> 
> The ade7854_i2c_write_reg_32() function returns 6 on success which makes
> no sense.  It should be zero or negative error codes.  All the write_reg
> functions in drivers/staging/iio/meter/ade7854-i2c.c have the same bug.
> 
> Please, fix that instead and leave ade7854_initial_setup() alone.

I see. However, I think the following steps could be better:

1) Update ade7854_i2c_write_reg() in order to return 0

The primary objective of this patchset it removes the duplications
related to write_reg_* and read_reg_*. As a result, in the first patch
create the function ade7854_i2c_write_reg(). I will add the following
code to fix the problem that we are discussing:

ade7854_i2c_write_reg() {
...
ret = i2c_master_send(st->i2c, st->tx, count);
...
return ret < 0 ? ret : 0;
}

With this, I do not need to touch any of the
ade7854_i2c_write_reg_(8|16|24|32) functions. 

2) Drop out the last patch from the patchset

Is that ok? If so, I will send the V2 today.
 
> regards,
> dan carpenter
> 
