Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeIOXGc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Sep 2018 19:06:32 -0400
Date: Sat, 15 Sep 2018 23:16:34 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: peda@axentia.se, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Julia.Lawall@lip6.fr
Subject: Re: [PATCH -next] iio: potentiometer: mcp4531: merge calls to
 of_match_device and of_device_get_match_data
Message-ID: <20180915174634.GA15225@himanshu-Vostro-3559>
References: <20180915105430.24052-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180915105430.24052-1-yuehaibing@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 15, 2018 at 06:54:30PM +0800, YueHaibing wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Already applied!
https://lore.kernel.org/lkml/20180819201752.2280be76@archlinux/

Anyway, if you want to work on making similar changes, you may
refer the following cocci script:

I tested[1] the changes through 0-day and had few false positives
and regressions. Therefore, check the results and compile test
the changes before sending patches.


Julia, and I had tried to make the confidence "High" but few 
cases were difficult to resolve, and later neither of us had 
time to look back at it again.

Not all maintainers will acknowledge such a change, but IIRC
Rob Herring gave a thumbs up on few cases on the dt-mailing list.


[1] https://github.com/himanshujha199640/linux-next/commit/efb7ed923bd00c86fe0a4e67e2ddb636ff0e0ff4

---------------------------------------------------------------------

/// Use of_device_get_match_data() to get matched data in an OF driver
//# of_device_get_match_data() returns const * and therefore the left
//# argument of assignment should also be a const * for compatible
//# types.
///
// Confidence: Moderate
// Copyright: (C) 2018 Himanshu Jha, GPLv2.
// Copyright: (C) 2018 Julia Lawall, INRIA/LIP6.  GPLv2.
// Keywords: of_match_device, of_device_get_match_data

virtual patch
virtual context
virtual org
virtual report


@r1 depends on patch && !context && !org && !report@
expression x,y,z;
identifier match;
type T;
statement S;
@@

- match = of_match_device(x, y);
(
- if(match==NULL) S
- z = match->data;
+ z = of_device_get_match_data(y);
|
- if(match==NULL) S
- z = (T *)match->data;
+ z = of_device_get_match_data(y);
|
- if(match==NULL) S
- z = (T)match->data;
+ z = (T)of_device_get_match_data(y);
|
- if(match!= NULL)
- z = match->data;
+ z = of_device_get_match_data(y);
|
- if(match!= NULL)
- z = (T *)match->data;
+ z = of_device_get_match_data(y);
|
- if(match!= NULL)
- z = (T)match->data;
+ z = (T)of_device_get_match_data(y);
)
... when != match

@r2 depends on r1 && patch && !context && !org && !report@
type T1;
expression e;
identifier r1.match;
@@

(
- T1 match = e;
|
- T1 match;
)

// ----------------------------------------------------------------------------

@r1_context depends on !patch && (context || org || report)@
type T;
identifier match;
statement S;
expression x, y, z;
position j0, j1;
@@

*  match@j0 = of_match_device(x, y);
(
*  if(match==NULL) S
*  z = match@j1->data;
|
*  if(match==NULL) S
*  z = (T *)match@j1->data;
|
*  if(match==NULL) S
*  z = (T)match@j1->data;
|
*  if(match!= NULL)
*  z = match@j1->data;
|
*  if(match!= NULL)
*  z = (T *)match@j1->data;
|
*  if(match!= NULL)
*  z = (T)match@j1->data;
)
... when != match

@r2_context depends on r1 && !patch && (context || org || report)@
type T1;
identifier r1_context.match;
expression e;
position j0;
@@

(
*  T1 match@j0 = e;
|
*  T1 match@j0;
)

// ----------------------------------------------------------------------------

@script:python r1_org depends on org@
j0 << r1_context.j0;
j1 << r1_context.j1;
@@

msg = "WARNING: opportunity for of_device_get_match_data."
coccilib.org.print_todo(j0[0], msg)
coccilib.org.print_link(j1[0], "")

// ----------------------------------------------------------------------------

@script:python r1_report depends on report@
j0 << r1_context.j0;
j1 << r1_context.j1;
@@

msg = "WARNING: opportunity for of_device_get_match_data around line %s." % (j1[0].line)
coccilib.report.print_report(j0[0], msg)

---------------------------------------------------------------------


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
