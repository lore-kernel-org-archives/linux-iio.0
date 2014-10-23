Return-Path: <bvandre@gmail.com>
Date: Thu, 23 Oct 2014 07:42:43 -0500
From: Brian Vandre <bvandre@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	gregkh@linuxfoundation.org, jic23@kernel.org,
	alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org,
	marex@denx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: iio: adc: fix line over 80 characters
Message-ID: <20141023124243.GA10433@brian-U>
References: <cover.1413858979.git.bvandre@gmail.com>
 <cover.1413931615.git.bvandre@gmail.com>
 <ec4b497827f6c7615f6b5eef5669144f8c68d034.1413931615.git.bvandre@gmail.com>
 <20141022042115.GA2530@sudip-PC>
 <5448DD58.7030705@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5448DD58.7030705@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 23, 2014 at 12:50:00PM +0200, Lars-Peter Clausen wrote:
> On 10/22/2014 06:21 AM, Sudip Mukherjee wrote:
> >On Tue, Oct 21, 2014 at 05:56:47PM -0500, Brian Vandre wrote:
> >>This fixes the 2 checkpatch.pl warnings:
> >>WARNING: line over 80 characters
> >>
> >please check your patch with --strict option of checkpatch.pl , and you will get :
> >"Alignment should match open parenthesis" .
> 
> Those checkpatch warnings are suggestions, not hard requirements.
> The idea is to improve code legibility, but if the change has the
> adverse effect the warning can and should be ignored. Also when
> making a change you should keep the existing indention style of a
> file.
> 
> - Lars

I think my patch does follow the style of the original file.  If you run checkpatch.pl --strict
on the whole file you will get many open parenthesis warnings. I believe it does make it slightly
more legibile.
