Return-Path: <SRS0=D4ap=GG=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 16 Mar 2018 17:17:27 +0300
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
Message-ID: <20180316141727.ia3mrwnmtkge7elm@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
 <20180316080257.dlglfjespmltwo3u@mwanda>
 <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Generally, it's better to fix the bug in the existing code, and then
do the cleanup later.  That way the fixes can be backported to stable
kernels more easily.

I don't know this subsystem very well.  Perhaps Jonathan doesn't care
for one reason or another (like maybe he's not going to back port the
fix).  So it might not matter how you do it.

regards,
dan carpenter
