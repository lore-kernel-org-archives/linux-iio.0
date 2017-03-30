Return-Path: <SRS0=eIxb=3H=gmail.com=singhalsimran0@kernel.org>
Date: Fri, 31 Mar 2017 00:10:38 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH v2] iio: light: lm3533-als: constify attribute_group
 structures
Message-ID: <20170330184038.GA11591@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Check for attribute_group structures that are only stored in the
event_attrs filed of iio_info structure. As the event_attrs field of
iio_info structures is constant, so these attribute_group structures can
also be declared constant. Done using coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct attribute_group i@p = {...};

@ok1@
identifier r1.i;
position p;
struct iio_info x;
@@
x.event_attrs=&i@p;

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
static
+const
struct attribute_group i={...};

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct attribute_group i;

As the attrs field of iio_info structures is also constant, so these
attribute_group structures can also be declared constant. Done manually.

File size before:
   text    data     bss     dec     hex filename
   5798    2376       0    8174    1fee drivers/iio/light/lm3533-als.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   5926	   2248	      0	   8174	   1fee	drivers/iio/light/lm3533-als.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 v2:
   -make one more attribute_group const.
   -change the values of file size after.
   -change commit message.

 drivers/iio/light/lm3533-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index f409c20..0443fd2 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -690,7 +690,7 @@ static struct attribute *lm3533_als_event_attributes[] = {
 	NULL
 };
 
-static struct attribute_group lm3533_als_event_attribute_group = {
+static const struct attribute_group lm3533_als_event_attribute_group = {
 	.attrs = lm3533_als_event_attributes
 };
 
@@ -714,7 +714,7 @@ static struct attribute *lm3533_als_attributes[] = {
 	NULL
 };
 
-static struct attribute_group lm3533_als_attribute_group = {
+static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-- 
2.7.4
