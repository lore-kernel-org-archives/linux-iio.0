Return-Path: <cristina.opriceana@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55A26683.8060507@gmx.de>
References: <cover.1436524490.git.cristina.opriceana@gmail.com>
	<05d86faf7f3799fd8320aed19f9a465b17bfb2ff.1436524490.git.cristina.opriceana@gmail.com>
	<55A03C5B.1010707@gmx.de>
	<CAFA9rWN=vE2SqGVodds0q9o1MVGLbCi70GhAggyCSU55GupqPA@mail.gmail.com>
	<55A26683.8060507@gmx.de>
Date: Sun, 12 Jul 2015 16:57:27 +0300
Message-ID: <CAFA9rWM=SXCztymEZNSgx1-HiDvTenRqNgwRy4EXYh3zoycaDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools: iio: Move printf failure messages to stderr
From: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
	octavian.purdila@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 12, 2015 at 4:07 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Cristina Georgiana Opriceana schrieb am 12.07.2015 um 13:38:
>> On Sat, Jul 11, 2015 at 12:42 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>>> Cristina Opriceana schrieb am 10.07.2015 um 12:56:
>>>> Replace printf error messages with fprintf(stderr, ...) in order
>>>> to ensure consistency and to make faults easier to identify.
>>>> This patch uses coccinelle to detect and apply the changes.
>>>>
>>>
>>> Hi Cristina,
>>> I just had a look at the series. You have all cases I regard necessary
>>> covered. There are however a few cases which probably qualify as error
>>> messages, too. Please see inline.
>>> However, for my personal taste, this could have been merged all in a
>>> single patch. Especially the third patch should have been included in
>>> this one (as during review, people certainly think that you missed the
>>> second line, just to find it fixed two patches later).
>>
>> Hi,
>>
>> Yes, I could have included all in a single patch, but I tried to
>> automatize this task and build a rather generic semantic patch in
>> coccinelle for the substitutions. Had I included all in one patch, the
>> changes with coccinelle wouldn't have been differentiated from the
>> other ones. If that is okay, I think I can merge them in one patch.
>>
>
> Point taken for making it reproducible. I just like to raise awareness:
> The maintainers are very busy. They have a full time job, respond to the
> mailing list, review patches and do all the git magic. That keeps them
> pretty busy, so I would aim to make the maintainers life as easy as possible.
> Checking just one patch against some sources can be quicker/easier than
> checking multiple ones. Same goes for applying patches.
> Other than that, I just feel strong about the third patch standing separate,
> which I don't regard a good idea. Either your script should have been
> extended to catch such cases, or if it is not worth the effort, it should
> have been changed by hand. But it should have gone in one pass.

Okay, I'll resend it all merged.
Thanks for the feedback!

Cristina

>>>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>>  - s/failiure/failure
>>>>
>>>>  tools/iio/generic_buffer.c    | 17 ++++++++++-------
>>>>  tools/iio/iio_event_monitor.c |  6 +++---
>>>>  tools/iio/iio_utils.c         | 34 ++++++++++++++++++++--------------
>>>>  3 files changed, 33 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
>>>> index 0e73723..2f4e12f 100644
>>>> --- a/tools/iio/generic_buffer.c
>>>> +++ b/tools/iio/generic_buffer.c
>>>> @@ -271,7 +271,7 @@ int main(int argc, char **argv)
>>>>       }
>>>>
>>>>       if (device_name == NULL) {
>>>> -             printf("Device name not set\n");
>>>> +             fprintf(stderr, "Device name not set\n");
>>>>               print_usage();
>>>>               return -1;
>>>>       }
>>>> @@ -279,7 +279,7 @@ int main(int argc, char **argv)
>>>>       /* Find the device requested */
>>>>       dev_num = find_type_by_name(device_name, "iio:device");
>>>>       if (dev_num < 0) {
>>>> -             printf("Failed to find the %s\n", device_name);
>>>> +             fprintf(stderr, "Failed to find the %s\n", device_name);
>>>>               return dev_num;
>>>>       }
>>>>
>>>> @@ -307,7 +307,8 @@ int main(int argc, char **argv)
>>>>               /* Verify the trigger exists */
>>>>               trig_num = find_type_by_name(trigger_name, "trigger");
>>>>               if (trig_num < 0) {
>>>> -                     printf("Failed to find the trigger %s\n", trigger_name);
>>>> +                     fprintf(stderr, "Failed to find the trigger %s\n",
>>>> +                             trigger_name);
>>>>                       ret = trig_num;
>>>>                       goto error_free_triggername;
>>>>               }
>>>> @@ -323,7 +324,7 @@ int main(int argc, char **argv)
>>>>        */
>>>>       ret = build_channel_array(dev_dir_name, &channels, &num_channels);
>>>>       if (ret) {
>>>> -             printf("Problem reading scan element information\n");
>>>> +             fprintf(stderr, "Problem reading scan element information\n");
>>>>               printf("diag %s\n", dev_dir_name);
>>>
>>> My preference would even be to print it all in just one fprintf.
>>
>> I thought so, also, but the string would go beyond 80 characters and
>> would have to be split which is ugly and brings a warning on it.
>>
>
> I just gave it a try compile testing:
>                 fprintf(stderr, "Problem reading scan element information\n"
>                         "diag %s\n", dev_dir_name);
>
> Compiled just fine, and the same format is used in your second patch as well.
>
>>>>               goto error_free_triggername;
>>>>       }
>>>> @@ -350,7 +351,8 @@ int main(int argc, char **argv)
>>>>                                                   dev_dir_name,
>>>>                                                   trigger_name);
>>>>               if (ret < 0) {
>>>> -                     printf("Failed to write current_trigger file\n");
>>>> +                     fprintf(stderr,
>>>> +                             "Failed to write current_trigger file\n");
>>>>                       goto error_free_buf_dir_name;
>>>>               }
>>>>       }
>>>> @@ -382,7 +384,7 @@ int main(int argc, char **argv)
>>>>       fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
>>>>       if (fp == -1) { /* TODO: If it isn't there make the node */
>>>>               ret = -errno;
>>>> -             printf("Failed to open %s\n", buffer_access);
>>>> +             fprintf(stderr, "Failed to open %s\n", buffer_access);
>>>>               goto error_free_buffer_access;
>>>>       }
>>>>
>>>
>>> At line 410 we have a block:
>>>                 read_size = read(fp, data, toread * scan_size);
>>>                 if (read_size < 0) {
>>>                         if (errno == EAGAIN) {
>>>                                 printf("nothing available\n");
>>>                                 continue;
>>>
>>> I'm tempted to say,that this should go to stderr, as well. Any opinions?
>>
>> I see it more as an informing note, since the device continues looping
>> for data, but it could be considered an error as well.
>
> I thought about the case when stdout gets piped to a data file while stderr
> goes into a logfile (or an application reads one data stream while checking
> the error stream).
>
>>
>>>> @@ -431,7 +433,8 @@ int main(int argc, char **argv)
>>>>               ret = write_sysfs_string("trigger/current_trigger",
>>>>                                        dev_dir_name, "NULL");
>>>>               if (ret < 0)
>>>> -                     printf("Failed to write to %s\n", dev_dir_name);
>>>> +                     fprintf(stderr, "Failed to write to %s\n",
>>>> +                             dev_dir_name);
>>>>
>>>>  error_close_buffer_access:
>>>>       if (close(fp) == -1)
>>>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>>>> index 703f4cb..843bc4c 100644
>>>> --- a/tools/iio/iio_event_monitor.c
>>>> +++ b/tools/iio/iio_event_monitor.c
>>>
>>> At line 217:
>>>         if (!event_is_known(event)) {
>>>                 printf("Unknown event: time: %lld, id: %llx\n",
>>>                        event->timestamp, event->id);
>>>
>>>                 return;
>>> Better have this on stderr, as well?
>>
>> This is more suitable for stderr, indeed.
>>
>>>> @@ -278,14 +278,14 @@ int main(int argc, char **argv)
>>>>       fd = open(chrdev_name, 0);
>>>>       if (fd == -1) {
>>>>               ret = -errno;
>>>> -             fprintf(stdout, "Failed to open %s\n", chrdev_name);
>>>> +             fprintf(stderr, "Failed to open %s\n", chrdev_name);
>>>>               goto error_free_chrdev_name;
>>>>       }
>>>>
>>>>       ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
>>>>       if (ret == -1 || event_fd == -1) {
>>>>               ret = -errno;
>>>> -             fprintf(stdout, "Failed to retrieve event fd\n");
>>>> +             fprintf(stderr, "Failed to retrieve event fd\n");
>>>>               if (close(fd) == -1)
>>>>                       perror("Failed to close character device file");
>>>>
>>>
>>> A similar borderline case as above in line 301:
>>>                 ret = read(event_fd, &event, sizeof(event));
>>>                 if (ret == -1) {
>>>                         if (errno == EAGAIN) {
>>>                                 printf("nothing available\n");
>>>                                 continue;
>>>
>>>> @@ -311,7 +311,7 @@ int main(int argc, char **argv)
>>>>               }
>>>>
>>>>               if (ret != sizeof(event)) {
>>>> -                     printf("Reading event failed!\n");
>>>> +                     fprintf(stderr, "Reading event failed!\n");
>>>>                       ret = -EIO;
>>>>                       break;
>>>>               }
>>>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>>>> index 8fb3214..46dfa3f 100644
>>>> --- a/tools/iio/iio_utils.c
>>>> +++ b/tools/iio/iio_utils.c
>>>> @@ -140,7 +140,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>>>                       sysfsfp = fopen(filename, "r");
>>>>                       if (sysfsfp == NULL) {
>>>>                               ret = -errno;
>>>> -                             printf("failed to open %s\n", filename);
>>>> +                             fprintf(stderr, "failed to open %s\n",
>>>> +                                     filename);
>>>>                               goto error_free_filename;
>>>>                       }
>>>>
>>>> @@ -152,7 +153,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>>>                                    &padint, shift);
>>>>                       if (ret < 0) {
>>>>                               ret = -errno;
>>>> -                             printf("failed to pass scan type description\n");
>>>> +                             fprintf(stderr,
>>>> +                                     "failed to pass scan type description\n");
>>>>                               goto error_close_sysfsfp;
>>>>                       } else if (ret != 5) {
>>>>                               ret = -EIO;
>>>> @@ -170,7 +172,8 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>>>                       *is_signed = (signchar == 's');
>>>>                       if (fclose(sysfsfp)) {
>>>>                               ret = -errno;
>>>> -                             printf("Failed to close %s\n", filename);
>>>> +                             fprintf(stderr, "Failed to close %s\n",
>>>> +                                     filename);
>>>>                               goto error_free_filename;
>>>>                       }
>>>>
>>>> @@ -454,7 +457,8 @@ int build_channel_array(const char *device_dir,
>>>>                       sysfsfp = fopen(filename, "r");
>>>>                       if (sysfsfp == NULL) {
>>>>                               ret = -errno;
>>>> -                             printf("failed to open %s\n", filename);
>>>> +                             fprintf(stderr, "failed to open %s\n",
>>>> +                                     filename);
>>>>                               free(filename);
>>>>                               goto error_cleanup_array;
>>>>                       }
>>>> @@ -581,11 +585,13 @@ int find_type_by_name(const char *name, const char *type)
>>>>                       ret = sscanf(ent->d_name + strlen(type), "%d", &number);
>>>>                       if (ret < 0) {
>>>>                               ret = -errno;
>>>> -                             printf("failed to read element number\n");
>>>> +                             fprintf(stderr,
>>>> +                                     "failed to read element number\n");
>>>>                               goto error_close_dir;
>>>>                       } else if (ret != 1) {
>>>>                               ret = -EIO;
>>>> -                             printf("failed to match element number\n");
>>>> +                             fprintf(stderr,
>>>> +                                     "failed to match element number\n");
>>>>                               goto error_close_dir;
>>>>                       }
>>>>
>>>> @@ -664,7 +670,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
>>>>       sysfsfp = fopen(temp, "w");
>>>>       if (sysfsfp == NULL) {
>>>>               ret = -errno;
>>>> -             printf("failed to open %s\n", temp);
>>>> +             fprintf(stderr, "failed to open %s\n", temp);
>>>>               goto error_free;
>>>>       }
>>>>
>>>> @@ -685,7 +691,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
>>>>               sysfsfp = fopen(temp, "r");
>>>>               if (sysfsfp == NULL) {
>>>>                       ret = -errno;
>>>> -                     printf("failed to open %s\n", temp);
>>>> +                     fprintf(stderr, "failed to open %s\n", temp);
>>>>                       goto error_free;
>>>>               }
>>>>
>>>> @@ -750,7 +756,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>>>       char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>>>
>>>>       if (temp == NULL) {
>>>> -             printf("Memory allocation failed\n");
>>>> +             fprintf(stderr, "Memory allocation failed\n");
>>>>               return -ENOMEM;
>>>>       }
>>>>
>>>> @@ -761,7 +767,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>>>       sysfsfp = fopen(temp, "w");
>>>>       if (sysfsfp == NULL) {
>>>>               ret = -errno;
>>>> -             printf("Could not open %s\n", temp);
>>>> +             fprintf(stderr, "Could not open %s\n", temp);
>>>>               goto error_free;
>>>>       }
>>>>
>>>> @@ -782,7 +788,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
>>>>               sysfsfp = fopen(temp, "r");
>>>>               if (sysfsfp == NULL) {
>>>>                       ret = -errno;
>>>> -                     printf("Could not open file to verify\n");
>>>> +                     fprintf(stderr, "Could not open file to verify\n");
>>>>                       goto error_free;
>>>>               }
>>>>
>>>> @@ -856,7 +862,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
>>>>       char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>>>
>>>>       if (temp == NULL) {
>>>> -             printf("Memory allocation failed");
>>>> +             fprintf(stderr, "Memory allocation failed");
>>>>               return -ENOMEM;
>>>>       }
>>>>
>>>> @@ -903,7 +909,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
>>>>       char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>>>
>>>>       if (temp == NULL) {
>>>> -             printf("Memory allocation failed");
>>>> +             fprintf(stderr, "Memory allocation failed");
>>>>               return -ENOMEM;
>>>>       }
>>>>
>>>> @@ -950,7 +956,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
>>>>       char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
>>>>
>>>>       if (temp == NULL) {
>>>> -             printf("Memory allocation failed");
>>>> +             fprintf(stderr, "Memory allocation failed");
>>>>               return -ENOMEM;
>>>>       }
>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
