Return-Path: <SRS0=Y5MG=MT=gmail.com=himanshujha199640@kernel.org>
Date: Sun, 7 Oct 2018 23:10:14 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: fix 'assignment operator' style
 checks
Message-ID: <20181007174014.GA21345@himanshu-Vostro-3559>
References: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHd-oW7Xpr-+1SuxsjduFhrRqh7TcGTqmJ22A7W7Oqk8o2E1Kg@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Oct 05, 2018 at 10:24:26PM -0300, Matheus Tavares Bernardino wrote:
> This patch fixes all "Assignment operator '=' should be on the previous
> line" checks found in ad2s1210.c by checkpatch.pl.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

As already pointed out tabs -> whitespace issue.

I assume you attached or copied the patch into your email
client and sent it. Usually, these clients wrap the message
which leads to patch corruption and hence it would apply
to the maintainer's git tree cleanly.

Therefore, I would suggest using `git send-email`.

Also, as a safety measure you may use the `--dry-run` flag
of `git send-email` to see how it would look like when you
send the patch.


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
