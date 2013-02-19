Return-Path: <manuel.stahl@iis.fraunhofer.de>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: "Getz, Robin" <robin.getz@analog.com>
Subject: Re: Userspace libs
Date: Tue, 19 Feb 2013 09:38:33 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 "Clausen, Lars-Peter" <Lars-Peter.Clausen@analog.com>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <201302131412.58742.robin.getz@analog.com> <511F7FA5.7060805@kernel.org> <201302181515.36379.robin.getz@analog.com>
In-Reply-To: <201302181515.36379.robin.getz@analog.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302190938.33405.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Robin,

On Monday, 18. February 2013 21:15:35 Getz, Robin wrote:
> On Sat 16 Feb 2013 07:46, Jonathan Cameron pondered:
> > On 02/13/2013 07:12 PM, Getz, Robin wrote:
> > > Jonathan:
> [snip]
> > The original plan was to have a separately maintained 
> > userspace library to do things 'properly'.
> 
> Where was this suppost to live?

We started a project on sourceforge some time ago. It's currently a bit out of date, but you're welcome to throw away the existing parts and replace it with your code.
The main tool right now is called 'lsiio' and does the same as 'lsusb' or 'lspci'.

http://sourceforge.net/projects/iioutils/

-- 
Regards,
Manuel Stahl
